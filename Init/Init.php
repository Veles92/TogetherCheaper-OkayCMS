<?php

namespace Okay\Modules\Astra\TogetherCheaper\Init;

use Okay\Core\Cart;
use Okay\Core\Modules\AbstractInit;
use Okay\Core\Modules\EntityField;
use Okay\Modules\Astra\TogetherCheaper\Entities\BundleEntity;
use Okay\Modules\Astra\TogetherCheaper\Extenders\BundleDiscountExtender;

class Init extends AbstractInit
{
    public const PERMISSION = 'astra__together_cheaper';
    public const DISCOUNT_SIGN = 'Astra_bundle';

    public function install(): void
    {
        $this->setBackendMainController('BundleListAdmin');
        $this->migrateBundleTable();
    }

    /**
     * Міграція схеми для переходу на чисту Astra-структуру v1.1.0.
     */
    public function update_1_1_0(): void
    {
        $this->migrateBundleTable();
    }

    public function init(): void
    {
        $this->registerBackendController('BundleListAdmin');
        $this->registerBackendController('BundleEditAdmin');
        $this->addBackendControllerPermission('BundleListAdmin', self::PERMISSION);
        $this->addBackendControllerPermission('BundleEditAdmin', self::PERMISSION);

        $this->extendBackendMenu('left_catalog', [
            'astra_together_cheaper__menu_title' => [
                'BundleListAdmin',
                'BundleEditAdmin',
            ],
        ]);

        $this->extendUpdateObject(
            'astra__together_cheaper',
            self::PERMISSION,
            BundleEntity::class
        );

        $this->registerPurchaseDiscountSign(
            self::DISCOUNT_SIGN,
            'discount_Astra_bundle_name',
            'discount_Astra_bundle_description'
        );

        // Queue-extension принципово виконується ПІСЛЯ всіх chain-extension цього методу.
        // Тому Veles/Promo спочатку завершує власний розрахунок, а потім комплект
        // лише доводить суму пари до заданої bundle_price, не даючи подвійного дисконту.
        $this->registerQueueExtension(
            ['class' => Cart::class, 'method' => 'applyPurchasesDiscounts'],
            ['class' => BundleDiscountExtender::class, 'method' => 'applyBundleDiscounts']
        );
    }

    private function migrateBundleTable(): void
    {
        $this->migrateEntityTable(BundleEntity::class, [
            (new EntityField('id'))->setIndexPrimaryKey()->setTypeInt(11, false)->setAutoIncrement(),
            (new EntityField('name'))->setTypeVarchar(255)->setDefault(''),
            (new EntityField('primary_product_id'))->setTypeInt(11, false)->setIndex(),
            (new EntityField('primary_variant_id'))->setTypeInt(11, false)->setIndex(),
            (new EntityField('secondary_product_id'))->setTypeInt(11, false)->setIndex(),
            (new EntityField('secondary_variant_id'))->setTypeInt(11, false)->setIndex(),
            (new EntityField('bundle_price'))->setTypeDecimal(14, 4)->setDefault(0),
            (new EntityField('visible'))->setTypeTinyInt(1, true)->setDefault(0)->setIndex(),
            (new EntityField('position'))->setTypeInt(11, true)->setDefault(0)->setIndex(),
            (new EntityField('created_at'))->setTypeDatetime(false),
            (new EntityField('updated_at'))->setTypeDatetime(false),
        ]);
    }
}
