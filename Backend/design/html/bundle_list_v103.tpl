{$meta_title = $btr->astra_together_cheaper__title scope=global}

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
    <div class="okay_list products_list fn_sort_list">
        <div class="okay_list_head">
            <div class="okay_list_heading okay_list_drag"></div>
            <div class="okay_list_heading okay_list_check"><input class="hidden_check fn_check_all" type="checkbox" id="check_all"><label class="okay_ckeckbox" for="check_all"></label></div>
            <div class="okay_list_heading okay_list_name">{$btr->astra_together_cheaper__bundle|escape}</div>
            <div class="okay_list_heading">{$btr->astra_together_cheaper__price_short|escape}</div>
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
                    <div class="okay_list_boding okay_list_name">
                        <a class="link" href="{url controller=[Astra,TogetherCheaper,BundleEditAdmin] id=$bundle->id return=$smarty.server.REQUEST_URI}">
                            {if $bundle->name}{$bundle->name|escape}{else}#{$bundle->id}{/if}
                        </a>
                        <div class="text_grey text_13">
                            {if $bundle->primary_product}{$bundle->primary_product->name|escape}{else}ID {$bundle->primary_product_id}{/if}
                            {if $bundle->primary_variant && $bundle->primary_variant->name} ({$bundle->primary_variant->name|escape}){/if}
                            &nbsp;+&nbsp;
                            {if $bundle->secondary_product}{$bundle->secondary_product->name|escape}{else}ID {$bundle->secondary_product_id}{/if}
                            {if $bundle->secondary_variant && $bundle->secondary_variant->name} ({$bundle->secondary_variant->name|escape}){/if}
                        </div>
                    </div>
                    <div class="okay_list_boding">
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

    {* Масові дії — структура 1:1 зі штатним footer списку товарів OkayCMS *}
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
