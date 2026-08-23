{$meta_title = $btr->astra_together_cheaper__edit_title scope=global}
<script src="design/js/autocomplete/jquery.autocomplete-min.js"></script>

<style>
    .atc-edit-header {
        margin-bottom: 16px;
    }

    .atc-edit-header .heading_page {
        color: #173b54;
        font-size: 24px;
        line-height: 1.25;
        font-weight: 700;
    }

    .atc-edit-header .btn {
        min-height: 40px;
        padding-left: 17px;
        padding-right: 17px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        border-radius: 8px;
        transition: background .18s ease, border-color .18s ease, box-shadow .18s ease, transform .18s ease;
    }

    .atc-edit-header .btn_blue {
        border-color: #173b54;
        background: #173b54;
        box-shadow: 0 3px 10px rgba(23, 59, 84, .16);
    }

    .atc-edit-header .btn_blue:hover {
        background: #214d6b;
        border-color: #214d6b;
        box-shadow: 0 5px 14px rgba(23, 59, 84, .22);
        transform: translateY(-1px);
    }

    .atc-admin-edit .atc-panel {
        margin-bottom: 16px;
        padding: 22px;
        border: 1px solid #e3e9ee;
        border-radius: 12px;
        background: #fff;
        box-shadow: 0 3px 14px rgba(31, 48, 61, .055);
    }

    .atc-admin-edit .atc-panel .heading_box {
       position: relative;
       margin-bottom: 18px;
       padding: 0 0 14px 13px;
       border-bottom: 1px solid #e6edf2;
       color: #173b54;
       font-size: 17px;
       line-height: 1.35;
       font-weight: 700;
    }

    .atc-admin-edit .atc-panel .heading_box:before {
       position: absolute;
       top: 1px;
       left: 0;
       width: 4px;
       height: 22px;
       content: "";
       border-radius: 4px;
       background: #c2683c;
    }

    .atc-admin-edit .atc-panel-products > .text_grey {
        margin-top: -8px;
        margin-bottom: 18px;
        color: #82909a;
        line-height: 1.5;
    }

    .atc-admin-edit .heading_label {
        margin-bottom: 7px;
        color: #475b68;
        font-size: 13px;
        line-height: 1.35;
        font-weight: 600;
    }

    .atc-admin-edit .form-control {
        min-height: 42px;
        border: 1px solid #d9e1e6;
        border-radius: 8px;
        background-color: #fff;
        box-shadow: none;
        color: #263943;
        transition: border-color .18s ease, box-shadow .18s ease;
    }

    .atc-admin-edit .form-control:hover {
        border-color: #bccbd4;
    }

    .atc-admin-edit .form-control:focus {
        border-color: #7897aa;
        box-shadow: 0 0 0 3px rgba(23, 59, 84, .08);
    }

.atc-admin-edit .bootstrap-select.form-control {
    width: 100% !important;
    padding: 0;
    border: 0;
    background: transparent;
    box-shadow: none;
}

.atc-admin-edit .bootstrap-select {
    width: 100% !important;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle {
    min-height: 42px;
    padding: 9px 38px 9px 14px;
    border: 1px solid #d9e1e6;
    border-radius: 10px;
    background: #fff;
    box-shadow: none;
    color: #263943;
    outline: none !important;
    transition: border-color .18s ease, box-shadow .18s ease, background .18s ease;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle:hover {
    border-color: #bccbd4;
    background: #fff;
}

.atc-admin-edit .bootstrap-select.open > .dropdown-toggle,
.atc-admin-edit .bootstrap-select > .dropdown-toggle:focus,
.atc-admin-edit .bootstrap-select > .dropdown-toggle:active {
    border-color: #7897aa !important;
    background: #fff !important;
    box-shadow: 0 0 0 3px rgba(23, 59, 84, .08) !important;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle .filter-option {
    display: flex;
    align-items: center;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle .filter-option-inner-inner {
    color: #263943;
    font-size: 14px;
    line-height: 1.35;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle {
    position: relative;
    padding-right: 42px !important;
}

.atc-admin-edit .bootstrap-select .bs-caret,
.atc-admin-edit .bootstrap-select .caret {
    display: none !important;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle::after {
    display: none !important;
    content: none !important;
}

.atc-admin-edit .bootstrap-select > .dropdown-toggle::before {
    position: absolute;
    top: 50%;
    right: 16px;
    width: 7px;
    height: 7px;
    content: "" !important;
    border: 0 !important;
    border-right: 2px solid #687d89 !important;
    border-bottom: 2px solid #687d89 !important;
    transform: translateY(-65%) rotate(45deg);
    pointer-events: none;
}

.atc-admin-edit .bootstrap-select .dropdown-menu {
    margin-top: 6px;
    padding: 6px;
    border: 1px solid #dfe6ea;
    border-radius: 10px;
    background: #fff;
    box-shadow: 0 10px 26px rgba(31, 48, 61, .14);
    overflow: hidden;
}

.atc-admin-edit .bootstrap-select .dropdown-menu.inner {
    padding: 0;
    border: 0;
    border-radius: 0;
    box-shadow: none;
}

.atc-admin-edit .bootstrap-select .bs-searchbox {
    padding: 0 0 6px 0;
    border-bottom: 1px solid #edf1f4;
    margin-bottom: 6px;
}

.atc-admin-edit .bootstrap-select .bs-searchbox input.form-control {
    min-height: 38px;
    height: 38px;
    padding: 8px 12px;
    border: 1px solid #d9e1e6;
    border-radius: 8px;
    background: #fff;
    box-shadow: none;
    color: #263943;
}

.atc-admin-edit .bootstrap-select .bs-searchbox input.form-control:focus {
    border-color: #7897aa;
    box-shadow: 0 0 0 3px rgba(23, 59, 84, .08);
}

.atc-admin-edit .bootstrap-select .dropdown-menu > li > a,
.atc-admin-edit .bootstrap-select .dropdown-menu .dropdown-item {
    display: flex;
    align-items: center;
    min-height: 38px;
    padding: 8px 12px;
    border-radius: 8px;
    background: transparent;
    color: #263943;
    font-size: 14px;
    line-height: 1.35;
    transition: background .16s ease, color .16s ease;
}

.atc-admin-edit .bootstrap-select .dropdown-menu > li > a:hover,
.atc-admin-edit .bootstrap-select .dropdown-menu > li > a:focus,
.atc-admin-edit .bootstrap-select .dropdown-menu .dropdown-item:hover,
.atc-admin-edit .bootstrap-select .dropdown-menu .dropdown-item:focus {
    background: #f3f7f9;
    color: #173b54;
    outline: none;
}

.atc-admin-edit .bootstrap-select .dropdown-menu > .active > a,
.atc-admin-edit .bootstrap-select .dropdown-menu > .active > a:hover,
.atc-admin-edit .bootstrap-select .dropdown-menu > .active > a:focus,
.atc-admin-edit .bootstrap-select .dropdown-menu .selected > a,
.atc-admin-edit .bootstrap-select .dropdown-menu .selected > a:hover,
.atc-admin-edit .bootstrap-select .dropdown-menu .selected > a:focus {
    background: #173b54;
    color: #fff;
}

.atc-admin-edit .bootstrap-select .no-results {
    margin: 0;
    padding: 10px 12px;
    color: #7f8f99;
    font-size: 13px;
    line-height: 1.4;
}

    .atc-admin-edit .atc-product-box {
        height: 100%;
        padding: 16px;
        border: 1px solid #e5eaee;
        border-radius: 10px;
        background: #fafcfd;
    }

    .atc-admin-edit .atc-product-box .heading_label.mt-1 {
        margin-top: 16px;
    }

    .atc-admin-edit .input-group .form-control {
        border-radius: 8px 0 0 8px;
    }

    .atc-admin-edit .input-group-addon {
        min-width: 48px;
        border: 1px solid #d9e1e6;
        border-left: 0;
        border-radius: 0 8px 8px 0;
        background: #f5f7f8;
        color: #596d79;
        font-weight: 600;
    }

    .atc-admin-edit .text_grey.text_13 {
        color: #82909a;
        line-height: 1.45;
    }

    .atc-admin-edit .atc-panel-settings {
        position: static;
    }

    .atc-admin-edit .atc-setting-row {
        padding: 14px 0;
        border-bottom: 1px solid #edf1f3;
    }

    .atc-admin-edit .atc-setting-row:first-of-type {
        padding-top: 0;
    }

    .atc-admin-edit .atc-setting-row:last-child {
        padding-bottom: 0;
        border-bottom: 0;
    }

    .atc-admin-edit .atc-setting-active {
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 16px;
    }

    .atc-admin-edit .atc-setting-active .heading_label {
        margin-bottom: 0;
    }

    .atc-admin-edit .atc-alert {
        min-height: 64px;
        display: flex !important;
        align-items: center !important;
        justify-content: space-between !important;
        gap: 16px;
        padding: 12px 16px !important;
        overflow: hidden;
        border-radius: 10px;
    }

    .atc-admin-edit .atc-alert__message {
        min-width: 0;
        display: flex;
        align-items: center;
        gap: 12px;
        margin: 0;
        padding: 0;
    }

    .atc-admin-edit .atc-alert__icon {
        width: 20px;
        height: 20px;
        flex: 0 0 20px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        margin: 0;
        padding: 0;
        color: #08751a;
    }

    .atc-admin-edit .atc-alert__icon svg {
        width: 18px !important;
        height: 18px !important;
        display: block !important;
        margin: 0 !important;
        fill: currentColor !important;
    }

    .atc-admin-edit .atc-alert__icon svg * {
        fill: currentColor !important;
    }

    .atc-admin-edit .atc-alert__text {
        display: block;
        margin: 0;
        padding: 0;
        color: inherit;
        font-size: inherit;
        font-weight: 600;
        line-height: 20px;
    }

    .atc-admin-edit .atc-alert__back {
        min-height: 38px !important;
        display: inline-flex !important;
        align-items: center !important;
        justify-content: center !important;
        gap: 7px;
        flex: 0 0 auto;
        margin: 0 !important;
        padding: 0 14px !important;
        border: 1px solid rgba(23, 59, 84, .18) !important;
        border-radius: 8px !important;
        background: #fff !important;
        color: #173b54 !important;
        font-size: 13px !important;
        line-height: 1 !important;
        font-weight: 600 !important;
        text-decoration: none !important;
        white-space: nowrap;
        box-shadow: 0 2px 7px rgba(31, 48, 61, .08) !important;
        transition: background .18s ease, border-color .18s ease, color .18s ease, box-shadow .18s ease, transform .18s ease;
    }

    .atc-admin-edit .atc-alert__back svg {
        width: 15px !important;
        height: 15px !important;
        display: block !important;
        margin: 0 !important;
        fill: currentColor !important;
    }

    .atc-admin-edit .atc-alert__back svg * {
        fill: currentColor !important;
    }

    .atc-admin-edit .atc-alert__back:hover,
    .atc-admin-edit .atc-alert__back:focus {
        border-color: #173b54 !important;
        background: #173b54 !important;
        color: #fff !important;
        text-decoration: none !important;
        box-shadow: 0 4px 11px rgba(23, 59, 84, .18) !important;
        transform: translateY(-1px);
    }

    .atc-admin-edit .atc-top-row {
        display: flex;
        flex-wrap: wrap;
        align-items: stretch;
    }

    .atc-admin-edit .atc-top-row > .col-lg-8,
    .atc-admin-edit .atc-top-row > .col-lg-4 {
        display: flex;
        float: none;
        flex-direction: column;
    }

    .atc-admin-edit .atc-top-row .atc-panel {
        flex: 1 1 auto;
        width: 100%;
        height: auto;
    }

    .atc-admin-edit .autocomplete-suggestions {
        margin-top: 4px;
        overflow: hidden;
        border: 1px solid #dfe6ea;
        border-radius: 8px;
        background: #fff;
        box-shadow: 0 8px 24px rgba(31, 48, 61, .14);
    }

    .atc-admin-edit .autocomplete-suggestion {
        padding: 9px 12px;
        border-bottom: 1px solid #eef2f4;
        cursor: pointer;
    }

    .atc-admin-edit .autocomplete-suggestion:last-child {
        border-bottom: 0;
    }

    .atc-admin-edit .autocomplete-selected {
        background: #f3f7f9;
    }

    @media (max-width: 991px) {
        .atc-admin-edit .atc-panel-settings {
            position: static;
        }

        .atc-admin-edit .atc-top-row > .col-lg-8,
        .atc-admin-edit .atc-top-row > .col-lg-4 {
            width: 100%;
        }
    }

    @media (max-width: 767px) {
        .atc-admin-edit .atc-panel {
            padding: 16px;
        }

        .atc-admin-edit .atc-product-box {
            margin-bottom: 8px;
        }

        .atc-edit-header {
            display: block !important;
            width: 100% !important;
            max-width: none !important;
            margin: 0 0 16px 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        .atc-edit-header .main_header__item {
            display: block !important;
            float: none !important;
            width: 100% !important;
            max-width: none !important;
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        .atc-edit-header .main_header__item:first-child {
            margin-bottom: 14px !important;
        }

        .atc-edit-header .main_header__inner {
            display: flex !important;
            width: 100% !important;
            max-width: none !important;
            margin: 0 !important;
            padding: 0 !important;
            box-sizing: border-box !important;
        }

        .atc-edit-header .main_header__item:first-child .main_header__inner {
            display: block !important;
        }

        .atc-edit-header .box_heading,
        .atc-edit-header .heading_page {
            width: 100% !important;
            max-width: none !important;
            margin: 0 !important;
        }

        .atc-edit-header .main_header__item:last-child .main_header__inner {
            flex-direction: column !important;
            align-items: stretch !important;
            justify-content: flex-start !important;
            flex-wrap: nowrap !important;
            gap: 8px !important;
        }

        .atc-edit-header .main_header__item:last-child .btn {
            display: flex !important;
            align-items: center !important;
            justify-content: center !important;
            width: 100% !important;
            min-width: 0 !important;
            max-width: none !important;
            min-height: 42px !important;
            height: 42px !important;
            margin: 0 !important;
            padding: 0 16px !important;
            box-sizing: border-box !important;
        }

        .atc-edit-header .main_header__item:last-child .btn.ml-1 {
            margin-left: 0 !important;
        }
    }
</style>


<form method="post" class="fn_fast_button atc-admin-edit">
    <input type="hidden" name="session_id" value="{$smarty.session.id}">
    <input type="hidden" name="id" value="{$bundle->id|intval}">

    <div class="main_header atc-edit-header">
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
            <div class="alert alert--center alert--success atc-alert">
                <div class="atc-alert__message">
                    <span class="atc-alert__icon">{include file='svg_icon.tpl' svgId='checked'}</span>
                    <span class="atc-alert__text">{if $message_success == 'added'}{$btr->general_success_added|default:'Додано'|escape}{else}{$btr->general_success_updated|default:'Оновлено'|escape}{/if}</span>
                </div>
                <a class="atc-alert__back" href="{if $smarty.get.return}{$smarty.get.return|escape}{else}{url controller=[Astra,TogetherCheaper,BundleListAdmin]}{/if}">
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

    <div class="row atc-top-row">
        <div class="col-lg-8 col-md-12">
            <div class="boxed mb-1 atc-panel atc-panel-products">
                <div class="heading_box">{$btr->astra_together_cheaper__section_products|escape}</div>
                <p class="text_grey text_13 mb-1">{$btr->astra_together_cheaper__products_hint|escape}</p>

                <div class="row">
                    <div class="col-md-6 mb-1">
                        <div class="atc-product-box">
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
                    </div>

                    <div class="col-md-6 mb-1">
                        <div class="atc-product-box">
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
            </div>
        </div>

        <div class="col-lg-4 col-md-12">
            <div class="boxed mb-1 atc-panel atc-panel-settings">
                <div class="heading_box">{$btr->astra_together_cheaper__settings|escape}</div>
                <div class="atc-setting-row atc-setting-active">
                    <div class="heading_label">{$btr->general_enable|default:'Активність'|escape}</div>
                    <label class="switch switch-default">
                        <input class="switch-input" name="visible" value="1" type="checkbox"{if $bundle->visible} checked{/if}>
                        <span class="switch-label" data-on="ON" data-off="OFF"></span>
                        <span class="switch-handle"></span>
                    </label>
                </div>
                <div class="atc-setting-row">
                    <div class="heading_label">{$btr->astra_together_cheaper__position|escape}</div>
                    <input class="form-control" type="number" name="position" value="{$bundle->position|intval}" min="0" step="1">
                    <div class="text_grey text_13 mt-h">{$btr->astra_together_cheaper__position_hint|escape}</div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-8 col-md-12">
            <div class="boxed mb-1 atc-panel atc-panel-price">
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
