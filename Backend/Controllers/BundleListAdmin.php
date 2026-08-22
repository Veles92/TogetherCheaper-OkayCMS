<?php

namespace Okay\Modules\Astra\TogetherCheaper\Backend\Controllers;

use Okay\Admin\Controllers\IndexAdmin;
use Okay\Entities\ProductsEntity;
use Okay\Entities\VariantsEntity;
use Okay\Entities\ImagesEntity;
use Okay\Modules\Astra\TogetherCheaper\Entities\BundleEntity;
use Okay\Modules\Astra\TogetherCheaper\Services\BundleService;

class BundleListAdmin extends IndexAdmin
{
    public function fetch(
        BundleEntity $bundlesEntity,
        ProductsEntity $productsEntity,
        VariantsEntity $variantsEntity,
        ImagesEntity $imagesEntity,
        BundleService $bundleService
    ) {
        if ($this->request->method('post')) {
            $ids = $this->request->post('check');
            if (is_array($ids)) {
                $ids = array_values(array_filter(array_map('intval', $ids)));
                $action = (string) $this->request->post('action', 'string');

                switch ($action) {
                    case 'enable':
                        $bundlesEntity->update($ids, ['visible' => 1]);
                        break;
                    case 'disable':
                        $bundlesEntity->update($ids, ['visible' => 0]);
                        break;
                    case 'delete':
                        $bundlesEntity->delete($ids);
                        break;
                    case 'duplicate':
                        foreach ($ids as $id) {
                            $bundle = $bundlesEntity->get($id);
                            if (empty($bundle->id)) {
                                continue;
                            }
                            $copy = clone $bundle;
                            unset($copy->id);
                            $copy->name = trim((string) $bundle->name) . ' (копія)';
                            $copy->created_at = date('Y-m-d H:i:s');
                            $copy->updated_at = date('Y-m-d H:i:s');
                            $bundlesEntity->add($copy);
                        }
                        break;
                }
            }

            $positions = $this->request->post('positions');
            if (!empty($positions) && is_array($positions)) {
                $ids = array_keys($positions);
                $positionValues = array_values($positions);
                sort($positionValues);
                foreach ($ids as $index => $id) {
                    $id = (int) $id;
                    if ($id > 0 && isset($positionValues[$index])) {
                        $bundlesEntity->update($id, ['position' => (int) $positionValues[$index]]);
                    }
                }
            }
        }

        $bundles = $bundlesEntity->find();
        $productIds = [];
        $variantIds = [];
        foreach ($bundles as $bundle) {
            $productIds[] = (int) $bundle->primary_product_id;
            $productIds[] = (int) $bundle->secondary_product_id;
            $variantIds[] = (int) $bundle->primary_variant_id;
            $variantIds[] = (int) $bundle->secondary_variant_id;
        }

        $products = [];
        if ($productIds) {
            $products = $productsEntity->mappedBy('id')->find([
                'id' => array_values(array_unique(array_filter($productIds))),
            ]);
        }

        $variants = [];
        if ($variantIds) {
            $variants = $variantsEntity->mappedBy('id')->find([
                'id' => array_values(array_unique(array_filter($variantIds))),
            ]);
        }

        $imageIds = [];
        foreach ($products as $product) {
            if (!empty($product->main_image_id)) {
                $imageIds[] = (int) $product->main_image_id;
            }
        }

        $images = [];
        if ($imageIds) {
            $images = $imagesEntity->mappedBy('id')->find([
                'id' => array_values(array_unique($imageIds)),
            ]);
        }

        foreach ($products as $product) {
            $product->image = !empty($product->main_image_id)
                ? ($images[(int) $product->main_image_id] ?? null)
                : null;
        }

        foreach ($bundles as $bundle) {
            $bundle->primary_product = $products[(int) $bundle->primary_product_id] ?? null;
            $bundle->secondary_product = $products[(int) $bundle->secondary_product_id] ?? null;
            $bundle->primary_variant = $variants[(int) $bundle->primary_variant_id] ?? null;
            $bundle->secondary_variant = $variants[(int) $bundle->secondary_variant_id] ?? null;

            $autoName = '';
            if (!empty($bundle->primary_product) && !empty($bundle->secondary_product)) {
                $autoName = trim((string) $bundle->primary_product->name . ' + ' . (string) $bundle->secondary_product->name);
            }
            $bundle->display_name = trim((string) $bundle->name);
            if ($bundle->display_name === '' || ($autoName !== '' && $bundle->display_name === $autoName)) {
                $bundle->display_name = 'Комплект #' . (int) $bundle->id;
            }

            $bundle->diagnostic = $bundleService->diagnose($bundle);
        }

        $this->design->assign('bundles', $bundles);
        $this->response->setContent($this->design->fetch('bundle_list.tpl'));
    }
}
