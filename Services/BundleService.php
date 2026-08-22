<?php

namespace Okay\Modules\Astra\TogetherCheaper\Services;

use Okay\Core\EntityFactory;
use Okay\Entities\VariantsEntity;
use Okay\Helpers\MoneyHelper;
use Okay\Helpers\ProductsHelper;
use Okay\Modules\Astra\TogetherCheaper\Entities\BundleEntity;

class BundleService
{
    /** @var ProductsHelper */
    private $productsHelper;

    /** @var MoneyHelper */
    private $moneyHelper;

    /** @var BundleEntity */
    private $bundlesEntity;

    /** @var VariantsEntity */
    private $variantsEntity;

    public function __construct(
        EntityFactory $entityFactory,
        ProductsHelper $productsHelper,
        MoneyHelper $moneyHelper
    ) {
        $this->productsHelper = $productsHelper;
        $this->moneyHelper = $moneyHelper;
        $this->bundlesEntity = $entityFactory->get(BundleEntity::class);
        $this->variantsEntity = $entityFactory->get(VariantsEntity::class);
    }

    /**
     * Повертає перший активний комплект для сторінки будь-якого товару з пари.
     * Товар може бути як primary, так і secondary. Порядок комплектів визначається
     * position, потім id.
     *
     * @param object $pageProduct
     * @return object|null
     */
    public function getForProduct($pageProduct): ?object
    {
        if (empty($pageProduct->id)) {
            return null;
        }

        $productId = (int) $pageProduct->id;
        $dealsById = [];

        foreach ([
            ['visible' => 1, 'primary_product_id' => $productId],
            ['visible' => 1, 'secondary_product_id' => $productId],
        ] as $filter) {
            $deals = $this->bundlesEntity->find($filter);
            foreach ($deals as $deal) {
                if (!empty($deal->id)) {
                    $dealsById[(int) $deal->id] = $deal;
                }
            }
        }

        if (empty($dealsById)) {
            return null;
        }

        $deals = array_values($dealsById);
        usort($deals, static function ($a, $b) {
            $positionCompare = ((int) ($a->position ?? 0)) <=> ((int) ($b->position ?? 0));
            if ($positionCompare !== 0) {
                return $positionCompare;
            }
            return ((int) ($a->id ?? 0)) <=> ((int) ($b->id ?? 0));
        });

        foreach ($deals as $deal) {
            $runtime = $this->prepareRuntimeDeal($deal, $pageProduct);
            if ($runtime !== null) {
                return $runtime;
            }
        }

        return null;
    }

    /**
     * Перевіряє комплект перед серверним додаванням у кошик.
     */
    public function getActiveById(int $id): ?object
    {
        if ($id < 1) {
            return null;
        }

        $deal = $this->bundlesEntity->get($id);
        if (empty($deal->id) || empty($deal->visible)) {
            return null;
        }

        return $this->prepareRuntimeDeal($deal);
    }

    /**
     * Готує комплект для фронтенду/кошика. Якщо передано товар поточної сторінки,
     * перевикористовуємо його готові дані незалежно від того, з якого боку пари
     * він знаходиться.
     *
     * @param object      $deal
     * @param object|null $pageProduct
     */
    private function prepareRuntimeDeal($deal, $pageProduct = null): ?object
    {
        if (
            empty($deal->primary_product_id)
            || empty($deal->secondary_product_id)
            || (int) $deal->primary_product_id === (int) $deal->secondary_product_id
            || (float) $deal->bundle_price <= 0
        ) {
            return null;
        }

        $primaryProductId = (int) $deal->primary_product_id;
        $secondaryProductId = (int) $deal->secondary_product_id;
        $pageProductId = !empty($pageProduct->id) ? (int) $pageProduct->id : 0;

        if ($pageProductId > 0 && $pageProductId !== $primaryProductId && $pageProductId !== $secondaryProductId) {
            return null;
        }

        $primaryProduct = $pageProductId === $primaryProductId
            ? $pageProduct
            : $this->loadProduct($primaryProductId);
        if (empty($primaryProduct) || empty($primaryProduct->id)) {
            return null;
        }

        $secondaryProduct = $pageProductId === $secondaryProductId
            ? $pageProduct
            : $this->loadProduct($secondaryProductId);
        if (empty($secondaryProduct) || empty($secondaryProduct->id)) {
            return null;
        }

        $primaryVariant = $this->findProductVariant($primaryProduct, (int) $deal->primary_variant_id);
        if ($primaryVariant === null || (float) $primaryVariant->stock < 1) {
            return null;
        }

        $secondaryVariant = $this->findProductVariant($secondaryProduct, (int) $deal->secondary_variant_id);
        if ($secondaryVariant === null || (float) $secondaryVariant->stock < 1) {
            return null;
        }

        $primaryPrice = (float) ($primaryVariant->price ?? 0);
        $secondaryPrice = (float) ($secondaryVariant->price ?? 0);
        $regularPrice = $primaryPrice + $secondaryPrice;
        $bundlePrice = round((float) $deal->bundle_price, 2);
        $saving = round($regularPrice - $bundlePrice, 2);

        // Якщо поточні ціни вже не дорожчі за комплект — блок не показуємо.
        if ($primaryPrice <= 0 || $secondaryPrice <= 0 || $saving <= 0) {
            return null;
        }

        $runtime = clone $deal;
        $runtime->primary_product = $primaryProduct;
        $runtime->primary_variant = $primaryVariant;
        $runtime->secondary_product = $secondaryProduct;
        $runtime->secondary_variant = $secondaryVariant;
        $runtime->regular_price = $regularPrice;
        $runtime->saving = $saving;
        $runtime->saving_percent = $regularPrice > 0
            ? round($saving / $regularPrice * 100, 0)
            : 0;
        $runtime->page_product_id = $pageProductId;

        return $runtime;
    }

    private function loadProduct(int $productId): ?object
    {
        if ($productId < 1) {
            return null;
        }

        $products = $this->productsHelper->getList([
            'id' => [$productId],
            'limit' => 1,
        ]);

        return !empty($products) ? reset($products) : null;
    }

    /**
     * Повертає потрібний варіант із уже підготовленого ProductsHelper товару.
     * Якщо варіант відсутній у прикріплених даних — перечитує його і конвертує
     * ціну в основну валюту.
     */
    private function findProductVariant($product, int $variantId): ?object
    {
        if ($variantId < 1 || empty($product->id)) {
            return null;
        }

        if (!empty($product->variants[$variantId])) {
            return $product->variants[$variantId];
        }

        $variant = $this->variantsEntity->get($variantId);
        if (empty($variant->id) || (int) $variant->product_id !== (int) $product->id) {
            return null;
        }

        return $this->moneyHelper->convertVariantPriceToMainCurrency($variant);
    }
}
