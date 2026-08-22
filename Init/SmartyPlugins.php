<?php

use Okay\Core\Design;
use Okay\Core\OkayContainer\Reference\ServiceReference as SR;
use Okay\Modules\Astra\TogetherCheaper\Plugins\ProductBundlePlugin;
use Okay\Modules\Astra\TogetherCheaper\Services\BundleService;

return [
    ProductBundlePlugin::class => [
        'class' => ProductBundlePlugin::class,
        'arguments' => [
            new SR(Design::class),
            new SR(BundleService::class),
        ],
    ],
];
