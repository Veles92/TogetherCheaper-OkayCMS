<?php

use Okay\Core\EntityFactory;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;
use Okay\Helpers\MoneyHelper;
use Okay\Helpers\ProductsHelper;
use Okay\Modules\Astra\TogetherCheaper\Extenders\BundleDiscountExtender;
use Okay\Modules\Astra\TogetherCheaper\Services\BundleService;

return [
    BundleService::class => [
        'class' => BundleService::class,
        'arguments' => [
            new SR(EntityFactory::class),
            new SR(ProductsHelper::class),
            new SR(MoneyHelper::class),
        ],
    ],

    BundleDiscountExtender::class => [
        'class' => BundleDiscountExtender::class,
        'arguments' => [
            new SR(EntityFactory::class),
        ],
    ],
];
