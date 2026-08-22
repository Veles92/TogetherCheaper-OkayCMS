<?php

namespace Okay\Modules\Astra\TogetherCheaper\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;
use Okay\Entities\ProductsEntity;
use Okay\Entities\VariantsEntity;
use Okay\Helpers\MoneyHelper;
use Okay\Modules\Astra\TogetherCheaper\Entities\BundleEntity;

class BundleEditAdmin extends IndexAdmin
{
    public function fetch(
        BundleEntity $bundlesEntity,
        ProductsEntity $productsEntity,
        VariantsEntity $variantsEntity,
        MoneyHelper $moneyHelper
    ) {
        if ($this->request->get('action') === 'variants') {
            $productId = (int) $this->request->get('product_id', 'integer');
            $variants = $this->loadVariants($variantsEntity, $moneyHelper, $productId);
            $items = [];
            foreach ($variants as $variant) {
                $items[] = [
                    'id' => (int) $variant->id,
                    'name' => trim((string) ($variant->name ?? '')),
                    'sku' => trim((string) ($variant->sku ?? '')),
                    'price' => (float) ($variant->price ?? 0),
                    'stock' => (float) ($variant->stock ?? 0),
                ];
            }
            $this->response->setContent(json_encode(['items' => $items], JSON_UNESCAPED_UNICODE), RESPONSE_JSON);
            return;
        }

        $messageError = null;
        $bundle = null;

        if ($this->request->method('post')) {
            $bundle = new \stdClass();
            $bundle->id = (int) $this->request->post('id', 'integer');
            $bundle->name = trim((string) $this->request->post('name', 'string'));
            $bundle->primary_product_id = (int) $this->request->post('primary_product_id', 'integer');
            $bundle->primary_variant_id = (int) $this->request->post('primary_variant_id', 'integer');
            $bundle->secondary_product_id = (int) $this->request->post('secondary_product_id', 'integer');
            $bundle->secondary_variant_id = (int) $this->request->post('secondary_variant_id', 'integer');
            $rawPrice = str_replace(',', '.', trim((string) $this->request->post('bundle_price')));
            $bundle->bundle_price = round((float) $rawPrice, 2);
            $bundle->visible = $this->request->post('visible') ? 1 : 0;
            $bundle->position = (int) $this->request->post('position', 'integer');

            $primaryProduct = $productsEntity->get($bundle->primary_product_id);
            $secondaryProduct = $productsEntity->get($bundle->secondary_product_id);

            if (empty($primaryProduct->id) || empty($secondaryProduct->id)) {
                $messageError = 'products_required';
            } elseif ((int) $primaryProduct->id === (int) $secondaryProduct->id) {
                $messageError = 'same_products';
            }

            $primaryVariants = $this->loadVariants($variantsEntity, $moneyHelper, $bundle->primary_product_id);
            $secondaryVariants = $this->loadVariants($variantsEntity, $moneyHelper, $bundle->secondary_product_id);

            if (!$messageError) {
                if (!isset($primaryVariants[$bundle->primary_variant_id])) {
                    $first = reset($primaryVariants);
                    $bundle->primary_variant_id = !empty($first->id) ? (int) $first->id : 0;
                }
                if (!isset($secondaryVariants[$bundle->secondary_variant_id])) {
                    $first = reset($secondaryVariants);
                    $bundle->secondary_variant_id = !empty($first->id) ? (int) $first->id : 0;
                }

                if ($bundle->primary_variant_id < 1 || $bundle->secondary_variant_id < 1) {
                    $messageError = 'variants_required';
                }
            }

            if (!$messageError && $bundle->bundle_price <= 0) {
                $messageError = 'price_required';
            }

            if (!$messageError) {
                $primaryVariant = $primaryVariants[$bundle->primary_variant_id];
                $secondaryVariant = $secondaryVariants[$bundle->secondary_variant_id];
                $regularPrice = (float) $primaryVariant->price + (float) $secondaryVariant->price;
                if ($bundle->bundle_price >= $regularPrice) {
                    $messageError = 'price_not_cheaper';
                }
            }

            if (!$messageError) {
                if ($bundle->name === '') {
                    $bundle->name = trim((string) $primaryProduct->name . ' + ' . (string) $secondaryProduct->name);
                }

                $bundle->updated_at = date('Y-m-d H:i:s');
                if (empty($bundle->id)) {
                    $bundle->created_at = $bundle->updated_at;
                    $bundle->id = (int) $bundlesEntity->add($bundle);
                    if ($bundle->id > 0) {
                        $this->postRedirectGet->storeMessageSuccess('added');
                        $this->postRedirectGet->storeNewEntityId($bundle->id);
                    } else {
                        $messageError = 'save_failed';
                    }
                } else {
                    $existing = $bundlesEntity->get($bundle->id);
                    if (empty($existing->id)) {
                        $messageError = 'not_found';
                    } else {
                        $bundlesEntity->update($bundle->id, (array) $bundle);
                        $this->postRedirectGet->storeMessageSuccess('updated');
                    }
                }

                if (!$messageError) {
                    $this->postRedirectGet->redirect();
                    return;
                }
            }
        } else {
            $bundleId = (int) $this->request->get('id', 'integer');
            if ($bundleId > 0) {
                $bundle = $bundlesEntity->get($bundleId);
            }

            if (empty($bundle)) {
                $bundle = (object) [
                    'id' => 0,
                    'name' => '',
                    'primary_product_id' => 0,
                    'primary_variant_id' => 0,
                    'secondary_product_id' => 0,
                    'secondary_variant_id' => 0,
                    'bundle_price' => 0,
                    'visible' => 0,
                    'position' => 0,
                ];
            }
        }

        $primaryProduct = !empty($bundle->primary_product_id)
            ? $productsEntity->get((int) $bundle->primary_product_id)
            : null;
        $secondaryProduct = !empty($bundle->secondary_product_id)
            ? $productsEntity->get((int) $bundle->secondary_product_id)
            : null;

        $primaryVariants = $this->loadVariants($variantsEntity, $moneyHelper, (int) $bundle->primary_product_id);
        $secondaryVariants = $this->loadVariants($variantsEntity, $moneyHelper, (int) $bundle->secondary_product_id);

        $this->design->assign('bundle', $bundle);
        $this->design->assign('primary_product', $primaryProduct);
        $this->design->assign('secondary_product', $secondaryProduct);
        $this->design->assign('primary_variants', $primaryVariants);
        $this->design->assign('secondary_variants', $secondaryVariants);
        $this->design->assign('bundle_message_error', $messageError);

        $this->response->setContent($this->design->fetch('bundle_edit.tpl'));
    }

    /**
     * @return array<int, object>
     */
    private function loadVariants(VariantsEntity $variantsEntity, MoneyHelper $moneyHelper, int $productId): array
    {
        if ($productId < 1) {
            return [];
        }

        $variants = $variantsEntity->mappedBy('id')->find(['product_id' => $productId]);
        if (empty($variants)) {
            return [];
        }

        return $moneyHelper->convertVariantsPriceToMainCurrency($variants);
    }
}
