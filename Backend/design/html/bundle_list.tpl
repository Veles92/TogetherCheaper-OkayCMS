{$meta_title = $btr->astra_together_cheaper__title scope=global}

<style>
    .atc_admin_list .atc_bundle_name {
        width: calc(100% - 650px);
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
    .atc_admin_list .atc_bundle_products_inner {
        display: flex;
        align-items: center;
        justify-content: center;
        gap: 10px;
        width: 100%;
    }
    .atc_admin_list .atc_bundle_product_photo {
        display: flex;
        align-items: center;
        justify-content: center;
        width: 58px;
        height: 58px;
        background: #fff;
        border: 1px solid #e8e8e8;
        border-radius: 4px;
        overflow: hidden;
    }
    .atc_admin_list .atc_bundle_product_photo img {
        display: block;
        max-width: 50px;
        max-height: 50px;
        width: auto;
        height: auto;
    }
    .atc_admin_list .atc_bundle_plus {
        flex: 0 0 auto;
        font-size: 20px;
        line-height: 1;
        font-weight: 600;
        color: #8c8c8c;
    }
    .atc_admin_list .atc_bundle_name .link {
        display: inline-block;
        max-width: 100%;
        font-weight: 500;
    }
    @media (max-width: 1199px) {
        .atc_admin_list .atc_bundle_name {
            width: calc(100% - 570px);
        }
        .atc_admin_list .atc_bundle_products {
            width: 150px;
            min-width: 150px;
        }
        .atc_admin_list .atc_bundle_product_photo {
            width: 50px;
            height: 50px;
        }
        .atc_admin_list .atc_bundle_product_photo img {
            max-width: 44px;
            max-height: 44px;
        }
    }
</style>

<div class="main_header">
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

<form method="post" class="fn_form_list">
<input type="hidden" name="session_id" value="{$smarty.session.id}">
{if $bundles}
<div class="boxed">
    <div class="okay_list products_list fn_sort_list atc_admin_list">
        <div class="okay_list_head">
            <div class="okay_list_heading okay_list_drag"></div>
            <div class="okay_list_heading okay_list_check"><input class="hidden_check fn_check_all" type="checkbox" id="check_all"><label class="okay_ckeckbox" for="check_all"></label></div>
            <div class="okay_list_heading atc_bundle_name">{$btr->astra_together_cheaper__bundle|escape}</div>
            <div class="okay_list_heading atc_bundle_products">{$btr->astra_together_cheaper__products|default:'Товари'|escape}</div>
            <div class="okay_list_heading atc_bundle_price">{$btr->astra_together_cheaper__price_short|escape}</div>
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
                    <select name="action" class="selectpicker form-control products_action">
                        <option value="enable">{$btr->general_do_enable|default:'Увімкнути'|escape}</option>
                        <option value="disable">{$btr->general_do_disable|default:'Вимкнути'|escape}</option>
                        <option value="duplicate">{$btr->general_create_dublicate|default:'Дублювати'|escape}</option>
                        <option value="delete">{$btr->general_delete|default:'Видалити'|escape}</option>
                    </select>
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
<div class="boxed"><div class="heading_box">{$btr->astra_together_cheaper__empty|escape}</div><p>{$btr->astra_together_cheaper__empty_hint|escape}</p></div>
{/if}
</form>
