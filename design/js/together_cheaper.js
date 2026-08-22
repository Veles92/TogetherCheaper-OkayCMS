(function ($) {
    'use strict';

    function moneyNumber(value) {
        var number = parseFloat(value);
        return isFinite(number) ? number : 0;
    }

    function trackAddToCart($button, quantity) {
        var moduleTracker = window.VelesGoogleAnalytics && window.VelesGoogleAnalytics.track;
        if (typeof moduleTracker !== 'function' && typeof window.gtag !== 'function') {
            return;
        }

        var total = moneyNumber($button.data('ga-price')) * quantity;
        var p1 = moneyNumber($button.data('ga-primary-regular'));
        var p2 = moneyNumber($button.data('ga-secondary-regular'));
        var regular = p1 + p2;
        var allocatedP1 = regular > 0 ? total * p1 / regular : total / 2;
        var allocatedP2 = total - allocatedP1;

        var eventData = {
            currency: window.VelesGoogleAnalytics && window.VelesGoogleAnalytics.pageData
                ? window.VelesGoogleAnalytics.pageData.currency
                : 'UAH',
            value: Number(total.toFixed(2)),
            items: [
                {
                    item_id: String($button.data('ga-primary-id')),
                    item_name: String($button.data('ga-primary-name') || ''),
                    item_variant: String($button.data('ga-primary-variant')),
                    price: Number(allocatedP1.toFixed(2)),
                    quantity: quantity
                },
                {
                    item_id: String($button.data('ga-secondary-id')),
                    item_name: String($button.data('ga-secondary-name') || ''),
                    item_variant: String($button.data('ga-secondary-variant')),
                    price: Number(allocatedP2.toFixed(2)),
                    quantity: quantity
                }
            ]
        };

        if (typeof moduleTracker === 'function') {
            moduleTracker('add_to_cart', eventData);
        } else {
            window.gtag('event', 'add_to_cart', eventData);
        }
    }

    $(document).on('click', '.fn_atc_add', function () {
        var $button = $(this);
        if ($button.prop('disabled')) {
            return;
        }

        var bundleId = parseInt($button.data('bundle-id'), 10) || 0;
        var route = String($button.data('route') || '');
        if (!route && typeof okay !== 'undefined' && okay.router) {
            route = okay.router['Astra_together_cheaper_add'] || '';
        }
        var defaultText = String($button.data('default-text') || $button.text());
        var loadingText = String($button.data('loading-text') || defaultText);
        var errorText = String($button.data('error-text') || 'Error');
        var $text = $button.find('.atc_bundle__button_text');

        if (!bundleId || !route) {
            window.alert(errorText);
            return;
        }

        $button.prop('disabled', true);
        $text.text(loadingText);

        $.ajax({
            url: route,
            type: 'POST',
            dataType: 'json',
            data: {
                bundle_id: bundleId,
                amount: 1
            }
        }).done(function (data) {
            if (!data || !data.success) {
                window.alert((data && data.message) ? data.message : errorText);
                return;
            }

            if (typeof window.ajax_set_result === 'function') {
                window.ajax_set_result(data);
            } else {
                if (data.cart_informer) { $('#cart_informer').html(data.cart_informer); }
                if (data.pop_up_cart) { $('#fn_pop_up_cart').html(data.pop_up_cart); }
            }

            trackAddToCart($button, parseInt(data.bundle_amount, 10) || 1);

            if ($.fancybox && $('#fn_pop_up_cart_wrap').length) {
                $.fancybox.open({
                    src: '#fn_pop_up_cart_wrap',
                    opts: { touch: false }
                });
            }
        }).fail(function () {
            window.alert(errorText);
        }).always(function () {
            $button.prop('disabled', false);
            $text.text(defaultText);
        });
    });
})(jQuery);
