{$meta_title = $btr->astra_together_cheaper__title scope=global}

<style>
    .atc-admin-header {
        margin-bottom: 16px;
    }

    .atc-admin-header .heading_page {
        font-size: 24px;
        line-height: 1.25;
        font-weight: 700;
        color: #173b54;
    }

    .atc-admin-header .btn-info {
        min-height: 40px;
        padding: 0 18px;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 7px;
        border: 0;
        border-radius: 8px;
        background: #173b54;
        box-shadow: 0 3px 10px rgba(23, 59, 84, .16);
        transition: background .2s ease, box-shadow .2s ease, transform .2s ease;
    }

    .atc-admin-header .btn-info:hover {
        background: #214d6b;
        box-shadow: 0 5px 14px rgba(23, 59, 84, .22);
        transform: translateY(-1px);
    }

    .atc-admin-page .atc-admin-list-card {
        padding: 0;
        overflow: visible;
        border: 1px solid #e3e9ee;
        border-radius: 12px;
        background: #fff;
        box-shadow: 0 3px 14px rgba(31, 48, 61, .06);
    }

    .atc-admin-page .atc_admin_list {
        overflow: visible;
        border-radius: 12px;
    }

    .atc-admin-page .atc_admin_list .okay_list_head {
        min-height: 48px;
        background: #f6f8fa;
        border-bottom: 1px solid #e3e9ee;
    }

    .atc-admin-page .atc_admin_list .okay_list_heading {
        color: #687985;
        font-size: 12px;
        line-height: 1.3;
        font-weight: 700;
        text-transform: uppercase;
        letter-spacing: .025em;
    }

    .atc_admin_list .atc_bundle_name {
        width: calc(100% - 840px);
        min-width: 260px;
        text-align: left;
    }

    .atc_admin_list .atc_bundle_products {
        width: 190px;
        min-width: 190px;
        text-align: center;
    }

    .atc_admin_list .atc_bundle_price {
        width: 110px;
        min-width: 110px;
        text-align: center;
    }

    .atc_admin_list .atc_bundle_diagnostic {
        width: 190px;
        min-width: 190px;
        text-align: left;
    }

    .atc-admin-page .atc_diag {
        display: flex;
        flex-direction: column;
        align-items: flex-start;
        gap: 5px;
        width: 100%;
    }

    .atc-admin-page .atc_diag_badge {
        display: inline-flex;
        align-items: center;
        gap: 7px;
        min-height: 30px;
        padding: 5px 10px;
        border: 1px solid transparent;
        border-radius: 999px;
        font-size: 12px;
        line-height: 1.25;
        font-weight: 700;
        white-space: nowrap;
    }

    .atc-admin-page .atc_diag_badge:before {
        flex: 0 0 7px;
        width: 7px;
        height: 7px;
        content: "";
        border-radius: 50%;
        background: currentColor;
    }

    .atc-admin-page .atc_diag_badge--success {
        border-color: #cde9d6;
        background: #eef9f1;
        color: #247844;
    }

    .atc-admin-page .atc_diag_badge--muted {
        border-color: #dde4e8;
        background: #f4f6f7;
        color: #6d7d87;
    }

    .atc-admin-page .atc_diag_badge--warning {
        border-color: #f0dcc7;
        background: #fff7ef;
        color: #a65d1d;
    }

    .atc-admin-page .atc_diag_badge--danger {
        border-color: #efcfd1;
        background: #fff2f3;
        color: #b3484e;
    }

    .atc-admin-page .atc_diag_badge[data-tooltip] {
        position: relative;
        cursor: help;
    }

    .atc-admin-page .atc_diag_badge[data-tooltip]:before {
        flex: 0 0 7px;
        width: 7px;
        height: 7px;
        content: "";
        border-radius: 50%;
        background: currentColor;
    }

    .atc-admin-page .atc_diag_badge[data-tooltip]:after {
        position: absolute;
        left: 50%;
        bottom: calc(100% + 10px);
        z-index: 10000;
        width: max-content;
        max-width: 270px;
        padding: 8px 10px;
        content: attr(data-tooltip);
        border: 1px solid #dfe6ea;
        border-radius: 8px;
        background: #173b54;
        box-shadow: 0 8px 22px rgba(31, 48, 61, .18);
        color: #fff;
        font-size: 12px;
        line-height: 1.4;
        font-weight: 400;
        text-align: left;
        white-space: normal;
        opacity: 0;
        visibility: hidden;
        transform: translate(-50%, 4px);
        transition: opacity .16s ease, visibility .16s ease, transform .16s ease;
        pointer-events: none;
    }

    .atc-admin-page .atc_diag_badge[data-tooltip]:hover:after {
        opacity: 1;
        visibility: visible;
        transform: translate(-50%, 0);
    }

    .atc-admin-page .atc_admin_list .okay_list_body_item:hover {
        position: relative;
        z-index: 30;
    }

    .atc-admin-page .atc_admin_list .okay_list_body_item {
        background: #fff;
        border-bottom: 1px solid #edf1f4;
        transition: background .18s ease, box-shadow .18s ease;
    }

    .atc-admin-page .atc_admin_list .okay_list_body_item:last-child {
        border-bottom: 0;
    }

    .atc-admin-page .atc_admin_list .okay_list_body_item:hover {
        background: #fafcfd;
        box-shadow: inset 3px 0 0 #c2683c;
    }

    .atc-admin-page .atc_admin_list .okay_list_row {
        min-height: 88px;
    }

    .atc_admin_list .atc_bundle_products_inner {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 8px;
        width: 100%;
    }

    .atc_admin_list .atc_bundle_product_photo {
        display: flex;
        align-items: center;
        justify-content: center;
        flex: 0 0 62px;
        width: 62px;
        height: 62px;
        padding: 4px;
        overflow: hidden;
        background: #fff;
        border: 1px solid #e1e7eb;
        border-radius: 10px;
        box-shadow: 0 2px 7px rgba(31, 48, 61, .05);
        transition: border-color .18s ease, box-shadow .18s ease, transform .18s ease;
    }

    .atc_admin_list a.atc_bundle_product_photo:hover {
        border-color: #b9c8d2;
        box-shadow: 0 4px 11px rgba(31, 48, 61, .11);
        transform: translateY(-1px);
    }

    .atc_admin_list .atc_bundle_product_photo img {
        display: block;
        width: auto;
        height: auto;
        max-width: 52px;
        max-height: 52px;
        object-fit: contain;
    }

    .atc_admin_list .atc_bundle_plus {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        flex: 0 0 24px;
        width: 24px;
        height: 24px;
        border-radius: 50%;
        background: #f0f3f5;
        color: #6d7d87;
        font-size: 18px;
        line-height: 1;
        font-weight: 600;
    }

    .atc_admin_list .atc_bundle_name .link {
        display: inline-block;
        max-width: 100%;
        color: #173b54;
        font-size: 14px;
        line-height: 1.45;
        font-weight: 600;
        transition: color .18s ease;
    }

    .atc_admin_list .atc_bundle_name .link:hover {
        color: #c2683c;
    }

    .atc-admin-page .atc_bundle_price strong {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        min-height: 34px;
        padding: 5px 11px;
        border-radius: 8px;
        background: #f3f7f9;
        color: #173b54;
        font-size: 14px;
        line-height: 1;
        font-weight: 700;
        white-space: nowrap;
    }

    .atc-admin-page .okay_list_drag svg {
        opacity: .42;
        transition: opacity .18s ease;
    }

    .atc-admin-page .okay_list_body_item:hover .okay_list_drag svg {
        opacity: .75;
    }

    .atc-admin-page .okay_list_close .btn_close {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 34px;
        height: 34px;
        margin: 0;
        padding: 0;
        border: 0;
        border-radius: 8px;
        background: transparent;
        transition: background .18s ease;
    }

    .atc-admin-page .okay_list_close .btn_close:hover {
        background: #fff0f0;
    }

    .atc-admin-page .okay_list_footer {
        min-height: 62px;
        padding-top: 10px;
        padding-bottom: 10px;
        background: #f8fafb;
        border-top: 1px solid #e3e9ee;
    }

    .atc-admin-page .okay_list_footer .btn_blue {
        min-height: 40px;
        padding-left: 18px;
        padding-right: 18px;
        border-radius: 8px;
        box-shadow: none;
    }

    .atc-admin-page .okay_list_footer {
        position: relative;
        overflow: visible !important;
    }

    .atc-admin-page .okay_list_footer .okay_list_foot_left,
    .atc-admin-page .okay_list_footer .okay_list_option {
        overflow: visible !important;
    }

    .atc-admin-page .okay_list_footer .okay_list_option {
        position: relative;
        width: 170px;
        min-width: 170px;
    }

    .atc-admin-page .atc-action-native {
        position: absolute !important;
        width: 1px !important;
        height: 1px !important;
        margin: 0 !important;
        padding: 0 !important;
        overflow: hidden !important;
        clip: rect(0 0 0 0) !important;
        white-space: nowrap !important;
        border: 0 !important;
        opacity: 0 !important;
        pointer-events: none !important;
    }

    .atc-admin-page .atc-action-select {
        position: relative;
        width: 170px;
        min-width: 170px;
        z-index: 20;
    }

    .atc-admin-page .atc-action-button {
        position: relative;
        display: flex;
        align-items: center;
        width: 170px;
        min-width: 170px;
        height: 40px;
        padding: 8px 40px 8px 14px;
        border: 1px solid #d9e1e6;
        border-radius: 8px;
        background: #fff;
        box-shadow: none;
        color: #263943;
        font-family: inherit;
        font-size: 14px;
        line-height: 1.35;
        text-align: left;
        cursor: pointer;
        outline: none;
        transition: border-color .18s ease, box-shadow .18s ease, background .18s ease;
    }

    .atc-admin-page .atc-action-button:hover {
        border-color: #bccbd4;
        background: #fff;
    }

    .atc-admin-page .atc-action-select.is-open .atc-action-button,
    .atc-admin-page .atc-action-button:focus {
        border-color: #7897aa;
        background: #fff;
        box-shadow: 0 0 0 3px rgba(23, 59, 84, .08);
    }

    .atc-admin-page .atc-action-button:after {
        position: absolute;
        top: 50%;
        right: 15px;
        width: 7px;
        height: 7px;
        content: "";
        border-right: 1.5px solid #526b79;
        border-bottom: 1.5px solid #526b79;
        transform: translateY(-68%) rotate(45deg);
        transition: transform .18s ease;
        pointer-events: none;
    }

    .atc-admin-page .atc-action-select.is-open .atc-action-button:after {
        transform: translateY(-28%) rotate(225deg);
    }

    .atc-admin-page .atc-action-menu {
        position: absolute;
        top: calc(100% + 6px);
        left: 0;
        z-index: 9999;
        display: none;
        width: 170px;
        min-width: 170px;
        margin: 0;
        padding: 6px;
        list-style: none;
        border: 1px solid #dfe6ea;
        border-radius: 10px;
        background: #fff;
        box-shadow: 0 10px 26px rgba(31, 48, 61, .14);
    }

    .atc-admin-page .atc-action-select.is-open .atc-action-menu {
        display: block;
    }

    .atc-admin-page .atc-action-select.is-dropup .atc-action-menu {
        top: auto;
        bottom: calc(100% + 6px);
    }

    .atc-admin-page .atc-action-item {
        display: flex;
        align-items: center;
        width: 100%;
        min-height: 38px;
        padding: 8px 12px;
        border: 0;
        border-radius: 8px;
        background: transparent;
        color: #263943;
        font-family: inherit;
        font-size: 14px;
        line-height: 1.35;
        text-align: left;
        white-space: nowrap;
        cursor: pointer;
        transition: background .16s ease, color .16s ease;
    }

    .atc-admin-page .atc-action-item:hover,
    .atc-admin-page .atc-action-item:focus {
        background: #f3f7f9;
        color: #173b54;
        outline: none;
    }

    .atc-admin-page .atc-action-item.is-selected {
        background: #8fa3af;
        color: #fff;
    }

    .atc-admin-page .atc-action-item.is-selected:hover,
    .atc-admin-page .atc-action-item.is-selected:focus {
        background: #7e949f;
        color: #fff;
    }

    .atc-admin-empty {
        padding: 34px 28px;
        text-align: center;
        border: 1px dashed #ccd7de;
        border-radius: 12px;
        background: #fafcfd;
    }

    .atc-admin-empty .heading_box {
        margin-bottom: 8px;
        color: #173b54;
        font-size: 18px;
        font-weight: 700;
    }

    .atc-admin-empty p {
        margin: 0;
        color: #7b8b95;
    }

    @media (max-width: 1199px) {
        .atc_admin_list .atc_bundle_name {
            width: calc(100% - 730px);
        }

        .atc_admin_list .atc_bundle_diagnostic {
            width: 160px;
            min-width: 160px;
        }

        .atc_admin_list .atc_bundle_products {
            width: 150px;
            min-width: 150px;
        }

        .atc_admin_list .atc_bundle_product_photo {
            flex-basis: 50px;
            width: 50px;
            height: 50px;
        }

        .atc_admin_list .atc_bundle_product_photo img {
            max-width: 42px;
            max-height: 42px;
        }

        .atc_admin_list .atc_bundle_plus {
            flex-basis: 20px;
            width: 20px;
            height: 20px;
            font-size: 16px;
        }
    }
</style>

<div class="main_header atc-admin-header">
    <div class="main_header__item">
        <div class="main_header__inner">
            <div class="box_heading heading_page">{$btr->astra_together_cheaper__title|escape}{if $bundles|count} — {$bundles|count}{/if}</div>
            <div class="box_btn_heading">
                <a class="btn btn_small btn-info" href="{url controller=[Astra,TogetherCheaper,BundleEditAdmin] return=$smarty.server.REQUEST_URI}">
                    {include file='svg_icon.tpl' svgId='plus'}
                    <span>{$btr->astra_together_cheaper__add|escape}</span>
                </a>
            </div>
        </div>
    </div>
</div>

<form method="post" class="fn_form_list atc-admin-page">
<input type="hidden" name="session_id" value="{$smarty.session.id}">
{if $bundles}
<div class="boxed atc-admin-list-card">
    <div class="okay_list products_list fn_sort_list atc_admin_list">
        <div class="okay_list_head">
            <div class="okay_list_heading okay_list_drag"></div>
            <div class="okay_list_heading okay_list_check"><input class="hidden_check fn_check_all" type="checkbox" id="check_all"><label class="okay_ckeckbox" for="check_all"></label></div>
            <div class="okay_list_heading atc_bundle_name">{$btr->astra_together_cheaper__bundle|escape}</div>
            <div class="okay_list_heading atc_bundle_products">{$btr->astra_together_cheaper__products|default:'Товари'|escape}</div>
            <div class="okay_list_heading atc_bundle_price">{$btr->astra_together_cheaper__price_short|escape}</div>
            <div class="okay_list_heading atc_bundle_diagnostic">{$btr->astra_together_cheaper__diagnostic|escape}</div>
            <div class="okay_list_heading okay_list_status">{$btr->general_enable|default:'Статус'|escape}</div>
            <div class="okay_list_heading okay_list_close"></div>
        </div>
        <div class="okay_list_body sortable">
        {foreach $bundles as $bundle}
            <div class="fn_row okay okay_list_body_item fn_sort_item">
                <div class="okay_list_row">
                    <div class="okay_list_boding okay_list_drag move_zone">
                        {include file='svg_icon.tpl' svgId='drag_vertical'}
                        <input type="hidden" name="positions[{$bundle->id}]" value="{$bundle->position|intval}">
                    </div>
                    <div class="okay_list_boding okay_list_check">
                        <input class="hidden_check" type="checkbox" name="check[]" value="{$bundle->id}" id="bundle_{$bundle->id}">
                        <label class="okay_ckeckbox" for="bundle_{$bundle->id}"></label>
                    </div>
                    <div class="okay_list_boding atc_bundle_name">
                        <a class="link" href="{url controller=[Astra,TogetherCheaper,BundleEditAdmin] id=$bundle->id return=$smarty.server.REQUEST_URI}">
                            {$bundle->display_name|escape}
                        </a>
                    </div>
                    <div class="okay_list_boding atc_bundle_products">
                        <div class="atc_bundle_products_inner">
                            {if $bundle->primary_product}
                                <a class="atc_bundle_product_photo hint-bottom-middle-t-info-s-small-mobile hint-anim"
                                   data-hint="{$bundle->primary_product->name|escape}"
                                   href="{url controller=ProductAdmin id=$bundle->primary_product->id return=$smarty.server.REQUEST_URI}">
                                    {if $bundle->primary_product->image}
                                        <img src="{$bundle->primary_product->image->filename|escape|resize:55:55}" alt="{$bundle->primary_product->name|escape}">
                                    {else}
                                        <img src="design/images/no_image.png" alt="">
                                    {/if}
                                </a>
                            {else}
                                <span class="atc_bundle_product_photo"><img src="design/images/no_image.png" alt=""></span>
                            {/if}
                            <span class="atc_bundle_plus">+</span>
                            {if $bundle->secondary_product}
                                <a class="atc_bundle_product_photo hint-bottom-middle-t-info-s-small-mobile hint-anim"
                                   data-hint="{$bundle->secondary_product->name|escape}"
                                   href="{url controller=ProductAdmin id=$bundle->secondary_product->id return=$smarty.server.REQUEST_URI}">
                                    {if $bundle->secondary_product->image}
                                        <img src="{$bundle->secondary_product->image->filename|escape|resize:55:55}" alt="{$bundle->secondary_product->name|escape}">
                                    {else}
                                        <img src="design/images/no_image.png" alt="">
                                    {/if}
                                </a>
                            {else}
                                <span class="atc_bundle_product_photo"><img src="design/images/no_image.png" alt=""></span>
                            {/if}
                        </div>
                    </div>
                    <div class="okay_list_boding atc_bundle_price">
                        <strong>{$bundle->bundle_price|convert} {$currency->sign|escape}</strong>
                    </div>
                    <div class="okay_list_boding atc_bundle_diagnostic">
                        <div class="atc_diag">
                            {if $bundle->diagnostic->code == 'active'}
                                <span class="atc_diag_badge atc_diag_badge--success">{$btr->astra_together_cheaper__diag_active|escape}</span>
                            {elseif $bundle->diagnostic->code == 'disabled'}
                                <span class="atc_diag_badge atc_diag_badge--muted">{$btr->astra_together_cheaper__diag_disabled|escape}</span>
                            {elseif $bundle->diagnostic->code == 'primary_out_of_stock'}
                                <span class="atc_diag_badge atc_diag_badge--warning" data-tooltip="{$btr->astra_together_cheaper__diag_primary_out_of_stock|escape}">{$btr->astra_together_cheaper__diag_out_of_stock|escape}</span>
                            {elseif $bundle->diagnostic->code == 'secondary_out_of_stock'}
                                <span class="atc_diag_badge atc_diag_badge--warning" data-tooltip="{$btr->astra_together_cheaper__diag_secondary_out_of_stock|escape}">{$btr->astra_together_cheaper__diag_out_of_stock|escape}</span>
                            {elseif $bundle->diagnostic->code == 'bundle_price_not_cheaper'}
                                <span class="atc_diag_badge atc_diag_badge--warning" data-tooltip="{$btr->astra_together_cheaper__diag_price_outdated_hint|escape}">{$btr->astra_together_cheaper__diag_price_outdated|escape}</span>
                            {elseif $bundle->diagnostic->code == 'product_price_invalid'}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_price_invalid_hint|escape}">{$btr->astra_together_cheaper__diag_price_invalid|escape}</span>
                            {elseif $bundle->diagnostic->code == 'primary_product_unavailable'}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_primary_product_unavailable|escape}">{$btr->astra_together_cheaper__diag_product_unavailable|escape}</span>
                            {elseif $bundle->diagnostic->code == 'secondary_product_unavailable'}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_secondary_product_unavailable|escape}">{$btr->astra_together_cheaper__diag_product_unavailable|escape}</span>
                            {elseif $bundle->diagnostic->code == 'primary_variant_unavailable'}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_primary_variant_unavailable|escape}">{$btr->astra_together_cheaper__diag_variant_unavailable|escape}</span>
                            {elseif $bundle->diagnostic->code == 'secondary_variant_unavailable'}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_secondary_variant_unavailable|escape}">{$btr->astra_together_cheaper__diag_variant_unavailable|escape}</span>
                            {else}
                                <span class="atc_diag_badge atc_diag_badge--danger" data-tooltip="{$btr->astra_together_cheaper__diag_invalid_config_hint|escape}">{$btr->astra_together_cheaper__diag_invalid_config|escape}</span>
                            {/if}
                        </div>
                    </div>
                    <div class="okay_list_boding okay_list_status">
                        <label class="switch switch-default">
                            <input class="switch-input fn_ajax_action {if $bundle->visible}fn_active_class{/if}"
                                   data-controller="astra__together_cheaper" data-action="visible" data-id="{$bundle->id}"
                                   name="visible" value="1" type="checkbox"{if $bundle->visible} checked{/if}>
                            <span class="switch-label"></span>
                            <span class="switch-handle"></span>
                        </label>
                    </div>
                    <div class="okay_list_boding okay_list_close">
                        <button data-hint="{$btr->general_delete|default:'Видалити'|escape}" type="button"
                                class="btn_close fn_remove hint-bottom-right-t-info-s-small-mobile hint-anim"
                                data-toggle="modal" data-target="#fn_action_modal" onclick="success_action($(this));">
                            {include file='svg_icon.tpl' svgId='trash'}
                        </button>
                    </div>
                </div>
            </div>
        {/foreach}
        </div>

        <div class="okay_list_footer fn_action_block">
            <div class="okay_list_foot_left">
                <div class="okay_list_boding okay_list_drag"></div>
                <div class="okay_list_heading okay_list_check">
                    <input class="hidden_check fn_check_all" type="checkbox" id="check_all_2" name="" value="">
                    <label class="okay_ckeckbox" for="check_all_2"></label>
                </div>
                <div class="okay_list_option">
                    <select name="action" class="products_action atc-action-native" id="atc_bulk_action">
                        <option value="enable">{$btr->general_do_enable|default:'Увімкнути'|escape}</option>
                        <option value="disable">{$btr->general_do_disable|default:'Вимкнути'|escape}</option>
                        <option value="duplicate">{$btr->general_create_dublicate|default:'Дублювати'|escape}</option>
                        <option value="delete">{$btr->general_delete|default:'Видалити'|escape}</option>
                    </select>

                    <div class="atc-action-select" id="atc_action_select">
                        <button type="button" class="atc-action-button" id="atc_action_button" aria-haspopup="listbox" aria-expanded="false">
                            <span id="atc_action_label">{$btr->general_do_enable|default:'Увімкнути'|escape}</span>
                        </button>
                        <div class="atc-action-menu" id="atc_action_menu" role="listbox">
                            <button type="button" class="atc-action-item is-selected" data-value="enable">{$btr->general_do_enable|default:'Увімкнути'|escape}</button>
                            <button type="button" class="atc-action-item" data-value="disable">{$btr->general_do_disable|default:'Вимкнути'|escape}</button>
                            <button type="button" class="atc-action-item" data-value="duplicate">{$btr->general_create_dublicate|default:'Дублювати'|escape}</button>
                            <button type="button" class="atc-action-item" data-value="delete">{$btr->general_delete|default:'Видалити'|escape}</button>
                        </div>
                    </div>
                </div>
            </div>
            <button type="submit" class="btn btn_small btn_blue">
                {include file='svg_icon.tpl' svgId='checked'}
                <span>{$btr->general_apply|default:'Застосувати'|escape}</span>
            </button>
        </div>
    </div>
</div>
{else}
<div class="boxed atc-admin-empty">
    <div class="heading_box">{$btr->astra_together_cheaper__empty|escape}</div>
    <p>{$btr->astra_together_cheaper__empty_hint|escape}</p>
</div>
{/if}
</form>


<script>
document.addEventListener('DOMContentLoaded', function () {
    var wrap = document.getElementById('atc_action_select');
    var button = document.getElementById('atc_action_button');
    var label = document.getElementById('atc_action_label');
    var menu = document.getElementById('atc_action_menu');
    var nativeSelect = document.getElementById('atc_bulk_action');

    if (!wrap || !button || !label || !menu || !nativeSelect) {
        return;
    }

    function closeMenu() {
        wrap.classList.remove('is-open');
        wrap.classList.remove('is-dropup');
        menu.style.visibility = '';
        button.setAttribute('aria-expanded', 'false');
    }

    function openMenu() {
        var buttonRect;
        var menuHeight;
        var spaceBelow;
        var spaceAbove;
        var safeBottom = 56;
        var gap = 6;

        wrap.classList.remove('is-dropup');
        menu.style.visibility = 'hidden';
        wrap.classList.add('is-open');

        buttonRect = button.getBoundingClientRect();
        menuHeight = menu.offsetHeight;
        spaceBelow = window.innerHeight - buttonRect.bottom - safeBottom;
        spaceAbove = buttonRect.top - 12;

        if (
            spaceBelow < menuHeight + gap ||
            buttonRect.top > window.innerHeight * 0.55
        ) {
            if (spaceAbove > 110) {
                wrap.classList.add('is-dropup');
            }
        }

        menu.style.visibility = '';
        button.setAttribute('aria-expanded', 'true');
    }

    button.addEventListener('click', function (event) {
        event.preventDefault();
        event.stopPropagation();

        if (wrap.classList.contains('is-open')) {
            closeMenu();
        } else {
            openMenu();
        }
    });

    menu.addEventListener('click', function (event) {
        var item = event.target.closest('.atc-action-item');

        if (!item) {
            return;
        }

        event.preventDefault();
        event.stopPropagation();

        var value = item.getAttribute('data-value');
        nativeSelect.value = value;
        label.textContent = item.textContent;

        Array.prototype.forEach.call(menu.querySelectorAll('.atc-action-item'), function (option) {
            option.classList.toggle('is-selected', option === item);
        });

        nativeSelect.dispatchEvent(new Event('change', { bubbles: true }));
        closeMenu();
        button.focus();
    });

    document.addEventListener('click', function (event) {
        if (!wrap.contains(event.target)) {
            closeMenu();
        }
    });

    document.addEventListener('keydown', function (event) {
        if (event.key === 'Escape') {
            closeMenu();
        }
    });
});
</script>
