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

    /** @var array<int, object|null> */
    private $productCache = [];

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
     * Повертає діагностику комплекту для адмін-панелі.
     * Для активного комплекту використовуються ті самі перевірки, що й для фронтенду.
     */
    public function diagnose($deal): object
    {
        if (empty($deal->visible)) {
            return (object) [
                'code' => 'disabled',
                'regular_price' => 0.0,
                'bundle_price' => round((float) ($deal->bundle_price ?? 0), 2),
                'saving' => 0.0,
            ];
        }

        $inspection = $this->inspectRuntimeDeal($deal);

        return (object) [
            'code' => $inspection->code,
            'regular_price' => $inspection->regular_price,
            'bundle_price' => $inspection->bundle_price,
            'saving' => $inspection->saving,
        ];
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
        $inspection = $this->inspectRuntimeDeal($deal, $pageProduct);
        return $inspection->runtime;
    }

    /**
     * Єдине джерело істини для runtime-перевірки комплекту та діагностики в адмінці.
     *
     * @param object      $deal
     * @param object|null $pageProduct
     */
    private function inspectRuntimeDeal($deal, $pageProduct = null): object
    {
        $bundlePrice = round((float) ($deal->bundle_price ?? 0), 2);
        $result = (object) [
            'runtime' => null,
            'code' => 'invalid_config',
            'regular_price' => 0.0,
            'bundle_price' => $bundlePrice,
            'saving' => 0.0,
        ];

        if (
            empty($deal->primary_product_id)
            || empty($deal->secondary_product_id)
            || (int) $deal->primary_product_id === (int) $deal->secondary_product_id
            || $bundlePrice <= 0
        ) {
            return $result;
        }

        $primaryProductId = (int) $deal->primary_product_id;
        $secondaryProductId = (int) $deal->secondary_product_id;
        $pageProductId = !empty($pageProduct->id) ? (int) $pageProduct->id : 0;

        if ($pageProductId > 0 && $pageProductId !== $primaryProductId && $pageProductId !== $secondaryProductId) {
            $result->code = 'not_for_page';
            return $result;
        }

        $primaryProduct = $pageProductId === $primaryProductId
            ? $pageProduct
            : $this->loadProduct($primaryProductId);
        if (empty($primaryProduct) || empty($primaryProduct->id)) {
            $result->code = 'primary_product_unavailable';
            return $result;
        }

        $secondaryProduct = $pageProductId === $secondaryProductId
            ? $pageProduct
            : $this->loadProduct($secondaryProductId);
        if (empty($secondaryProduct) || empty($secondaryProduct->id)) {
            $result->code = 'secondary_product_unavailable';
            return $result;
        }

        $primaryVariant = $this->findProductVariant($primaryProduct, (int) $deal->primary_variant_id);
        if ($primaryVariant === null) {
            $result->code = 'primary_variant_unavailable';
            return $result;
        }
        if ((float) $primaryVariant->stock < 1) {
            $result->code = 'primary_out_of_stock';
            return $result;
        }

        $secondaryVariant = $this->findProductVariant($secondaryProduct, (int) $deal->secondary_variant_id);
        if ($secondaryVariant === null) {
            $result->code = 'secondary_variant_unavailable';
            return $result;
        }
        if ((float) $secondaryVariant->stock < 1) {
            $result->code = 'secondary_out_of_stock';
            return $result;
        }

        $primaryPrice = (float) ($primaryVariant->price ?? 0);
        $secondaryPrice = (float) ($secondaryVariant->price ?? 0);
        $regularPrice = $primaryPrice + $secondaryPrice;
        $saving = round($regularPrice - $bundlePrice, 2);

        $result->regular_price = $regularPrice;
        $result->saving = $saving;

        if ($primaryPrice <= 0 || $secondaryPrice <= 0) {
            $result->code = 'product_price_invalid';
            return $result;
        }

        // Якщо поточні ціни вже не дорожчі за комплект — блок не показуємо.
        if ($saving <= 0) {
            $result->code = 'bundle_price_not_cheaper';
            return $result;
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

        $result->runtime = $runtime;
        $result->code = 'active';

        return $result;
    }

    private function loadProduct(int $productId): ?object
    {
        if ($productId < 1) {
            return null;
        }

        if (array_key_exists($productId, $this->productCache)) {
            return $this->productCache[$productId];
        }

        $products = $this->productsHelper->getList([
            'id' => [$productId],
            'limit' => 1,
        ]);

        $product = !empty($products) ? reset($products) : null;
        $this->productCache[$productId] = $product ?: null;

        return $this->productCache[$productId];
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
