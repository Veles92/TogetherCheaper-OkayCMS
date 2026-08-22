{$meta_title = $btr->astra_together_cheaper__edit_title scope=global}
<script src="design/js/autocomplete/jquery.autocomplete-min.js"></script>

<form method="post" class="fn_fast_button">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
    <input type="hidden" name="id" value="{$bundle->id|intval}">

    <div class="main_header">
        <div class="main_header__item">
            <div class="main_header__inner">
                <div class="box_heading heading_page">
                    {if $bundle->id}{$btr->astra_together_cheaper__edit_title|escape}{else}{$btr->astra_together_cheaper__add_title|escape}{/if}
                </div>
            </div>
        </div>
        <div class="main_header__item">
            <div class="main_header__inner">
                <button type="submit" class="btn btn_small btn_blue">
                    {include file='svg_icon.tpl' svgId='checked'}
                    <span>{$btr->general_apply|default:'Зберегти'|escape}</span>
                </button>
                <a class="btn btn_small btn_border-info ml-1" href="{if $smarty.get.return}{$smarty.get.return|escape}{else}{url controller=[Astra,TogetherCheaper,BundleListAdmin]}{/if}">
                    {include file='svg_icon.tpl' svgId='return'}
                    <span>{$btr->general_back|default:'Назад'|escape}</span>
                </a>
            </div>
        </div>
    </div>

    {if $message_success}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="alert alert--center alert--icon alert--success">
                <div class="alert__content"><div class="alert__title">
                    {if $message_success == 'added'}{$btr->general_success_added|default:'Додано'|escape}{else}{$btr->general_success_updated|default:'Оновлено'|escape}{/if}
                </div></div>
                <a class="alert__button" href="{if $smarty.get.return}{$smarty.get.return|escape}{else}{url controller=[Astra,TogetherCheaper,BundleListAdmin]}{/if}">
                    {include file='svg_icon.tpl' svgId='return'}
                    <span>{$btr->general_back|default:'Назад'|escape}</span>
                </a>
            </div>
        </div>
    </div>
    {/if}

    {if $bundle_message_error}
    <div class="row">
        <div class="col-lg-12 col-md-12 col-sm-12">
            <div class="alert alert--center alert--icon alert--error">
                <div class="alert__content"><div class="alert__title">
                    {if $bundle_message_error == 'products_required'}{$btr->astra_together_cheaper__error_products_required|escape}
                    {elseif $bundle_message_error == 'same_products'}{$btr->astra_together_cheaper__error_same_products|escape}
                    {elseif $bundle_message_error == 'variants_required'}{$btr->astra_together_cheaper__error_variants_required|escape}
                    {elseif $bundle_message_error == 'price_required'}{$btr->astra_together_cheaper__error_price_required|escape}
                    {elseif $bundle_message_error == 'price_not_cheaper'}{$btr->astra_together_cheaper__error_price_not_cheaper|escape}
                    {elseif $bundle_message_error == 'not_found'}{$btr->astra_together_cheaper__error_not_found|escape}
                    {elseif $bundle_message_error == 'save_failed'}{$btr->astra_together_cheaper__error_save_failed|escape}
                    {else}{$btr->general_error|default:'Помилка'|escape}{/if}
                </div></div>
            </div>
        </div>
    </div>
    {/if}

    <div class="row">
        <div class="col-lg-8 col-md-12">
            <div class="boxed mb-1">
                <div class="heading_box">{$btr->astra_together_cheaper__section_products|escape}</div>
                <p class="text_grey text_13 mb-1">{$btr->astra_together_cheaper__products_hint|escape}</p>

                <div class="row">
                    <div class="col-md-6 mb-1">
                        <div class="heading_label">{$btr->astra_together_cheaper__primary_product|escape}</div>
                        <input type="hidden" name="primary_product_id" id="atc_primary_product_id" value="{$bundle->primary_product_id|intval}">
                        <input type="text" class="form-control fn_atc_product" data-side="primary" id="atc_primary_product_search"
                               value="{if $primary_product}{$primary_product->name|escape}{/if}"
                               placeholder="{$btr->astra_together_cheaper__search_product|escape}" autocomplete="off">

                        <div class="heading_label mt-1">{$btr->astra_together_cheaper__variant|escape}</div>
                        <select class="selectpicker form-control fn_atc_variant" data-side="primary" id="atc_primary_variant_id" name="primary_variant_id" data-live-search="true">
                            {foreach $primary_variants as $variant}
                            <option value="{$variant->id}"{if $bundle->primary_variant_id == $variant->id} selected{/if}>
                                {if $variant->name}{$variant->name|escape}{else}{$primary_product->name|escape}{/if}{if $variant->sku} — {$variant->sku|escape}{/if} · {$variant->price|convert} {$currency->sign|escape}
                            </option>
                            {/foreach}
                        </select>
                    </div>

                    <div class="col-md-6 mb-1">
                        <div class="heading_label">{$btr->astra_together_cheaper__secondary_product|escape}</div>
                        <input type="hidden" name="secondary_product_id" id="atc_secondary_product_id" value="{$bundle->secondary_product_id|intval}">
                        <input type="text" class="form-control fn_atc_product" data-side="secondary" id="atc_secondary_product_search"
                               value="{if $secondary_product}{$secondary_product->name|escape}{/if}"
                               placeholder="{$btr->astra_together_cheaper__search_product|escape}" autocomplete="off">

                        <div class="heading_label mt-1">{$btr->astra_together_cheaper__variant|escape}</div>
                        <select class="selectpicker form-control fn_atc_variant" data-side="secondary" id="atc_secondary_variant_id" name="secondary_variant_id" data-live-search="true">
                            {foreach $secondary_variants as $variant}
                            <option value="{$variant->id}"{if $bundle->secondary_variant_id == $variant->id} selected{/if}>
                                {if $variant->name}{$variant->name|escape}{else}{$secondary_product->name|escape}{/if}{if $variant->sku} — {$variant->sku|escape}{/if} · {$variant->price|convert} {$currency->sign|escape}
                            </option>
                            {/foreach}
                        </select>
                    </div>
                </div>
            </div>

            <div class="boxed mb-1">
                <div class="heading_box">{$btr->astra_together_cheaper__section_price|escape}</div>
                <div class="row">
                    <div class="col-md-6 mb-1">
                        <div class="heading_label">{$btr->astra_together_cheaper__bundle_price|escape}</div>
                        <div class="input-group">
                            <input class="form-control" type="text" name="bundle_price" value="{$bundle->bundle_price|escape}">
                            <span class="input-group-addon">{$currency->sign|escape}</span>
                        </div>
                        <div class="text_grey text_13 mt-h">{$btr->astra_together_cheaper__price_hint|escape}</div>
                    </div>
                    <div class="col-md-6 mb-1">
                        <div class="heading_label">{$btr->astra_together_cheaper__name|escape}</div>
                        <input class="form-control" type="text" name="name" value="{$bundle->name|escape}" placeholder="{$btr->astra_together_cheaper__name_placeholder|escape}">
                        <div class="text_grey text_13 mt-h">{$btr->astra_together_cheaper__name_hint|escape}</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-12">
            <div class="boxed mb-1">
                <div class="heading_box">{$btr->astra_together_cheaper__settings|escape}</div>
                <div class="mb-1">
                    <div class="heading_label">{$btr->general_enable|default:'Активність'|escape}</div>
                    <label class="switch switch-default">
                        <input class="switch-input" name="visible" value="1" type="checkbox"{if $bundle->visible} checked{/if}>
                        <span class="switch-label" data-on="ON" data-off="OFF"></span>
                        <span class="switch-handle"></span>
                    </label>
                </div>
                <div>
                    <div class="heading_label">{$btr->astra_together_cheaper__position|escape}</div>
                    <input class="form-control" type="number" name="position" value="{$bundle->position|intval}" min="0" step="1">
                    <div class="text_grey text_13 mt-h">{$btr->astra_together_cheaper__position_hint|escape}</div>
                </div>
            </div>
        </div>
    </div>
</form>

{literal}
<script>
$(function () {
    function escapeResult(value) {
        return $('<div>').text(value == null ? '' : String(value)).html();
    }

    function loadVariants(side, productId) {
        var $select = $('#atc_' + side + '_variant_id');
        $select.empty();
        if ($select.data('selectpicker')) { $select.selectpicker('refresh'); }
        if (!productId) { return; }

        $.get('index.php', {
            controller: 'Astra.TogetherCheaper.BundleEditAdmin',
            action: 'variants',
            product_id: productId
        }, function (response) {
            var items = response && response.items ? response.items : [];
            $.each(items, function (_, item) {
                var label = item.name || ('ID ' + item.id);
                if (item.sku) { label += ' — ' + item.sku; }
                label += ' · ' + item.price;
                $select.append($('<option>', { value: item.id, text: label }));
            });
            if ($.fn.selectpicker) { $select.selectpicker('refresh'); }
        }, 'json');
    }

    $('.fn_atc_product').each(function () {
        var $input = $(this);
        var side = $input.data('side');
        $input.devbridgeAutocomplete({
            serviceUrl: 'ajax/search_products.php',
            type: 'POST',
            minChars: 0,
            noCache: false,
            onSelect: function (suggestion) {
                $('#atc_' + side + '_product_id').val(suggestion.data.id);
                $input.val(suggestion.data.name || suggestion.value);
                loadVariants(side, suggestion.data.id);
            },
            formatResult: function (suggestion) {
                var image = suggestion.data && suggestion.data.image ? '<img align="absmiddle" src="' + suggestion.data.image + '"> ' : '';
                return '<div>' + image + '</div><span>' + escapeResult(suggestion.value) + '</span>';
            }
        });
        $input.on('input', function () {
            $('#atc_' + side + '_product_id').val('');
            $('#atc_' + side + '_variant_id').empty();
            if ($.fn.selectpicker) { $('#atc_' + side + '_variant_id').selectpicker('refresh'); }
        });
    });
});
</script>
{/literal}
