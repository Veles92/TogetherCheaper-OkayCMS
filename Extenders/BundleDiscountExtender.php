<?php

namespace Okay\Modules\Astra\TogetherCheaper\Extenders;

use Okay\Core\Cart;
use Okay\Core\Classes\Discount;
use Okay\Core\Classes\Purchase;
use Okay\Core\EntityFactory;
use Okay\Core\Modules\Extender\ExtensionInterface;
use Okay\Modules\Astra\TogetherCheaper\Entities\BundleEntity;
use Okay\Modules\Astra\TogetherCheaper\Init\Init;

class BundleDiscountExtender implements ExtensionInterface
{
    /** @var BundleEntity */
    private $bundlesEntity;

    public function __construct(EntityFactory $entityFactory)
    {
        $this->bundlesEntity = $entityFactory->get(BundleEntity::class);
    }

    /**
     * Виконується queue-extension після всіх chain-extension Cart::applyPurchasesDiscounts().
     * Це дозволяє врахувати вже застосовані Veles/Promo та інші товарні знижки.
     *
     * Правило: комплект НІКОЛИ не робить існуючу вигіднішу ціну гіршою.
     * Якщо поточна сума двох одиниць > bundle_price — додається тільки різниця.
     * Якщо інша акція вже дала суму <= bundle_price — додаткова bundle-знижка = 0.
     */
    public function applyBundleDiscounts($cart): void
    {
        if (!$cart instanceof Cart || $cart->isEmpty || empty($cart->purchases)) {
            return;
        }

        $deals = $this->bundlesEntity->find(['visible' => 1]);
        if (empty($deals)) {
            return;
        }

        $rowsByVariant = [];
        $remaining = [];

        foreach ($cart->purchases as $key => $purchase) {
            if (!$purchase instanceof Purchase || $this->isPromoGift($purchase)) {
                continue;
            }

            $variantId = (int) ($purchase->variant_id ?? ($purchase->variant->id ?? 0));
            $amount = max(0, (int) ($purchase->amount ?? 0));
            if ($variantId < 1 || $amount < 1) {
                continue;
            }

            // У звичайному OkayCMS один variant_id має один рядок кошика.
            // Якщо інший модуль додасть дубль — беремо перший звичайний рядок.
            if (!isset($rowsByVariant[$variantId])) {
                $rowsByVariant[$variantId] = $purchase;
                $remaining[$variantId] = $amount;
            }
        }

        if (empty($rowsByVariant)) {
            return;
        }

        foreach ($deals as $deal) {
            $primaryVariantId = (int) ($deal->primary_variant_id ?? 0);
            $secondaryVariantId = (int) ($deal->secondary_variant_id ?? 0);
            $targetPairPrice = round((float) ($deal->bundle_price ?? 0), 2);

            if (
                $primaryVariantId < 1
                || $secondaryVariantId < 1
                || $primaryVariantId === $secondaryVariantId
                || $targetPairPrice <= 0
                || empty($rowsByVariant[$primaryVariantId])
                || empty($rowsByVariant[$secondaryVariantId])
            ) {
                continue;
            }

            $bundleCount = min(
                (int) ($remaining[$primaryVariantId] ?? 0),
                (int) ($remaining[$secondaryVariantId] ?? 0)
            );
            if ($bundleCount < 1) {
                continue;
            }

            $primaryPurchase = $rowsByVariant[$primaryVariantId];
            $secondaryPurchase = $rowsByVariant[$secondaryVariantId];

            $primaryCurrentUnit = $this->currentUnitPrice($primaryPurchase);
            $secondaryCurrentUnit = $this->currentUnitPrice($secondaryPurchase);
            $currentPairPrice = $primaryCurrentUnit + $secondaryCurrentUnit;
            $discountPerPair = round($currentPairPrice - $targetPairPrice, 2);

            // Інша акція вже вигідніша або ціна комплекту втратила актуальність.
            if ($discountPerPair <= 0) {
                continue;
            }

            $totalDiscount = round($discountPerPair * $bundleCount, 2);
            if ($totalDiscount <= 0) {
                continue;
            }

            // Знижку по можливості кладемо на рядок, у якому немає зайвих
            // незакомплектованих одиниць. Так для 1×A + 2×B у кошику B
            // залишається за звичайною ціною, а знижка повністю лягає на A,
            // замість штучного усереднення ціни двох B.
            $primaryRemaining = (int) ($remaining[$primaryVariantId] ?? 0);
            $secondaryRemaining = (int) ($remaining[$secondaryVariantId] ?? 0);
            if ($secondaryRemaining === $bundleCount) {
                $firstPurchase = $secondaryPurchase;
                $secondPurchase = $primaryPurchase;
            } else {
                $firstPurchase = $primaryPurchase;
                $secondPurchase = $secondaryPurchase;
            }

            $left = $this->applyDiscountToLine($firstPurchase, $totalDiscount, $deal);
            if ($left > 0) {
                $this->applyDiscountToLine($secondPurchase, $left, $deal);
            }

            $remaining[$primaryVariantId] -= $bundleCount;
            $remaining[$secondaryVariantId] -= $bundleCount;
        }

        $this->rebuildPurchaseDiscountTotals($cart);
        $this->rebuildPostPurchaseSubtotal($cart);
    }

    private function isPromoGift(Purchase $purchase): bool
    {
        if (!empty($purchase->variant->gift_product_id)) {
            return true;
        }
        if (!empty($purchase->meta->Veles_promo_bundle_free)) {
            return true;
        }
        return false;
    }

    private function currentUnitPrice(Purchase $purchase): float
    {
        $amount = max(1, (int) ($purchase->amount ?? 1));
        if (isset($purchase->meta->total_price)) {
            return round(max(0, (float) $purchase->meta->total_price) / $amount, 4);
        }
        return round(max(0, (float) ($purchase->price ?? 0)), 4);
    }

    /**
     * @return float залишок знижки, який не помістився в цей рядок
     */
    private function applyDiscountToLine(Purchase $purchase, float $requestedDiscount, $deal): float
    {
        if ($requestedDiscount <= 0) {
            return 0.0;
        }

        $amount = max(1, (int) ($purchase->amount ?? 1));
        $lineBefore = isset($purchase->meta->total_price)
            ? round(max(0, (float) $purchase->meta->total_price), 2)
            : round(max(0, (float) ($purchase->price ?? 0) * $amount), 2);

        if ($lineBefore <= 0) {
            return $requestedDiscount;
        }

        $applied = min($lineBefore, round($requestedDiscount, 2));
        $lineAfter = round($lineBefore - $applied, 2);
        $unitBefore = round($lineBefore / $amount, 4);
        $unitAfter = round($lineAfter / $amount, 4);
        $unitDiscount = round($unitBefore - $unitAfter, 4);

        if ($unitDiscount <= 0) {
            return $requestedDiscount;
        }

        $discount = new Discount();
        $discount->sign = Init::DISCOUNT_SIGN;
        $discount->type = 'absolute';
        $discount->value = $unitDiscount;
        $discount->fromLastDiscount = true;
        $discount->name = 'discount_Astra_bundle_name';
        $discount->description = 'discount_Astra_bundle_description';
        $discount->lang = [
            'name' => 'discount_Astra_bundle_name',
            'description' => 'discount_Astra_bundle_description',
        ];
        $discount->langParts = [
            'bundle_name' => (string) ($deal->name ?? ''),
        ];
        $discount->priceBeforeDiscount = $unitBefore;
        $discount->priceAfterDiscount = $unitAfter;
        $discount->absoluteDiscount = $unitDiscount;
        $discount->percentDiscount = $unitBefore > 0
            ? round($unitDiscount / $unitBefore * 100, 2)
            : 0.0;

        if (!isset($purchase->discounts) || !is_array($purchase->discounts)) {
            $purchase->discounts = [];
        }
        if (!isset($purchase->meta) || !is_object($purchase->meta)) {
            $purchase->meta = new \stdClass();
        }

        $purchase->discounts[] = $discount;
        $purchase->price = $unitAfter;
        $purchase->meta->total_price = $lineAfter;
        $purchase->meta->Astra_bundle = (object) [
            'id' => (int) ($deal->id ?? 0),
            'name' => (string) ($deal->name ?? ''),
            'bundle_price' => (float) ($deal->bundle_price ?? 0),
        ];

        return round(max(0, $requestedDiscount - $applied), 2);
    }

    private function rebuildPurchaseDiscountTotals(Cart $cart): void
    {
        $cart->total_purchases_discounts = [];

        foreach ($cart->purchases as $purchase) {
            $amount = max(1, (int) ($purchase->amount ?? 1));
            if (empty($purchase->discounts) || !is_array($purchase->discounts)) {
                continue;
            }

            foreach ($purchase->discounts as $discount) {
                if (!is_object($discount) || empty($discount->sign)) {
                    continue;
                }

                $sign = (string) $discount->sign;
                $absolute = (float) ($discount->absoluteDiscount ?? 0) * $amount;
                $before = (float) ($discount->priceBeforeDiscount ?? 0) * $amount;
                $after = (float) ($discount->priceAfterDiscount ?? 0) * $amount;

                if (!isset($cart->total_purchases_discounts[$sign])) {
                    $total = clone $discount;
                    $total->absoluteDiscount = $absolute;
                    $total->priceBeforeDiscount = $before;
                    $total->priceAfterDiscount = $after;
                    $total->percentDiscount = $before > 0 ? round($absolute / $before * 100, 2) : 0.0;
                    $cart->total_purchases_discounts[$sign] = $total;
                } else {
                    $total = $cart->total_purchases_discounts[$sign];
                    $total->absoluteDiscount += $absolute;
                    $total->priceBeforeDiscount += $before;
                    $total->priceAfterDiscount += $after;
                    $total->percentDiscount = $total->priceBeforeDiscount > 0
                        ? round($total->absoluteDiscount / $total->priceBeforeDiscount * 100, 2)
                        : 0.0;
                }
            }
        }
    }

    private function rebuildPostPurchaseSubtotal(Cart $cart): void
    {
        $cart->undiscounted_total_price = 0;

        foreach ($cart->purchases as $purchase) {
            $amount = max(1, (int) ($purchase->amount ?? 1));
            if (!isset($purchase->meta) || !is_object($purchase->meta)) {
                $purchase->meta = new \stdClass();
            }
            if (!isset($purchase->meta->total_price)) {
                $purchase->meta->total_price = round(max(0, (float) ($purchase->price ?? 0)) * $amount, 2);
            }

            $cart->undiscounted_total_price += (float) $purchase->meta->total_price;
        }

        $cart->undiscounted_total_price = round($cart->undiscounted_total_price, 2);
    }
}
