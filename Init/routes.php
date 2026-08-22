<?php

use Okay\Modules\Astra\TogetherCheaper\Controllers\BundleCartController;

return [
    'Astra_together_cheaper_add' => [
        'slug' => '/ajax/Astra_together_cheaper_add',
        'params' => [
            'controller' => BundleCartController::class,
            'method' => 'addBundle',
        ],
        'to_front' => true,
    ],
];
