<?php

namespace Okay\Modules\Astra\TogetherCheaper\Controllers;

use Okay\Controllers\AbstractController;
use Okay\Core\Cart;
use Okay\Core\Request;
use Okay\Helpers\CartHelper;
use Okay\Helpers\DeliveriesHelper;
use Okay\Helpers\PaymentsHelper;
use Okay\Modules\Astra\TogetherCheaper\Services\BundleService;

class BundleCartController extends AbstractController
{
    public function addBundle(
        Request $request,
        Cart $cart,
        BundleService $bundleService,
        CartHelper $cartHelper,
        PaymentsHelper $paymentsHelper,
        DeliveriesHelper $deliveriesHelper
    ) {
        $result = [
            'success' => 0,
            'message' => '',
        ];

        if (!$request->method('POST')) {
            $result['message'] = 'Method not allowed';
            $this->response->setContent(json_encode($result), RESPONSE_JSON);
            return;
        }

        $bundleId = (int) $request->post('bundle_id', 'integer');
        $amount = max(1, (int) $request->post('amount', 'integer'));
        $bundle = $bundleService->getActiveById($bundleId);

        if ($bundle === null) {
            $result['message'] = 'Bundle is unavailable';
            $this->response->setContent(json_encode($result), RESPONSE_JSON);
            return;
        }

        $cart = $cart->get();
        $currentAmounts = [];
        foreach ($cart->purchases as $purchase) {
            $currentAmounts[(int) $purchase->variant_id] = (int) $purchase->amount;
        }

        $primaryVariantId = (int) $bundle->primary_variant->id;
        $secondaryVariantId = (int) $bundle->secondary_variant->id;
        $primaryFreeStock = max(0, (int) $bundle->primary_variant->stock - (int) ($currentAmounts[$primaryVariantId] ?? 0));
        $secondaryFreeStock = max(0, (int) $bundle->secondary_variant->stock - (int) ($currentAmounts[$secondaryVariantId] ?? 0));
        $maxAmount = min($primaryFreeStock, $secondaryFreeStock);

        if ($maxAmount < 1) {
            $result['message'] = 'Bundle is out of stock';
            $this->response->setContent(json_encode($result), RESPONSE_JSON);
            return;
        }
        $amount = min($amount, $maxAmount);

        $cart->addItem($primaryVariantId, $amount);
        $cart->addItem($secondaryVariantId, $amount);
        $cart = $cart->get();

        $this->design->assign('cart', $cart);

        $paymentMethods = $paymentsHelper->getCartPaymentsList($cart);
        $deliveries = $deliveriesHelper->getCartDeliveriesList($cart, $paymentMethods);
        $ajax = $cartHelper->getAjaxCartResult(
            $cart,
            $this->currency,
            $paymentMethods,
            $deliveries,
            'add_bundle',
            (int) $bundle->primary_variant->id,
            $amount
        );

        $ajax['success'] = 1;
        $ajax['bundle_id'] = (int) $bundle->id;
        $ajax['bundle_amount'] = $amount;

        $this->response->setContent(json_encode($ajax), RESPONSE_JSON);
    }
}
