<?php

namespace Okay\Modules\Astra\TogetherCheaper\Entities;

use Okay\Core\Entity\Entity;

class BundleEntity extends Entity
{
    protected static $fields = [
        'id',
        'name',
        'primary_product_id',
        'primary_variant_id',
        'secondary_product_id',
        'secondary_variant_id',
        'bundle_price',
        'visible',
        'position',
        'created_at',
        'updated_at',
    ];

    protected static $defaultOrderFields = ['position ASC', 'id ASC'];
    protected static $table = 'astra__together_cheaper';
    protected static $tableAlias = 'atc';
}
