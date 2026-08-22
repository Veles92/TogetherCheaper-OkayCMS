<?php

namespace Okay\Modules\Astra\TogetherCheaper\Plugins;

use Okay\Core\Design;
use Okay\Core\SmartyPlugins\Func;
use Okay\Modules\Astra\TogetherCheaper\Services\BundleService;

class ProductBundlePlugin extends Func
{
    protected $tag = 'Astra_together_cheaper';

    /** @var Design */
    private $design;

    /** @var BundleService */
    private $bundleService;

    public function __construct(Design $design, BundleService $bundleService)
    {
        $this->design = $design;
        $this->bundleService = $bundleService;
    }

    public function run($vars)
    {
        if (empty($vars['product'])) {
            return '';
        }

        $bundle = $this->bundleService->getForProduct($vars['product']);
        if ($bundle === null) {
            return '';
        }

        $this->design->assign('astra_bundle', $bundle);
        return $this->design->fetch('together_cheaper.tpl');
    }
}
