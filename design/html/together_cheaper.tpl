{if $astra_bundle}
<div class="atc_bundle fn_atc_bundle" data-bundle-id="{$astra_bundle->id|intval}">
    <div class="atc_bundle__head">
        <div>
            <div class="atc_bundle__eyebrow">{$lang->Astra_together_cheaper__eyebrow|escape}</div>
            <div class="atc_bundle__title">{$lang->Astra_together_cheaper__title|escape}</div>
        </div>
        <div class="atc_bundle__saving">−{$astra_bundle->saving|convert} {$currency->sign|escape}</div>
    </div>

    <div class="atc_bundle__products">
        <div class="atc_bundle__product">
            <a class="atc_bundle__image" href="{url_generator route='product' url=$astra_bundle->primary_product->url}">
                {if $astra_bundle->primary_product->image}
                    <img src="{$astra_bundle->primary_product->image->filename|resize:120:120}" alt="{$astra_bundle->primary_product->name|escape}" loading="lazy">
                {else}
                    <span class="atc_bundle__noimage">{include file='svg.tpl' svgId='no_image'}</span>
                {/if}
            </a>
            <div class="atc_bundle__product_info">
                <a class="atc_bundle__product_name" href="{url_generator route='product' url=$astra_bundle->primary_product->url}">{$astra_bundle->primary_product->name|escape}</a>
                {if $astra_bundle->primary_variant->name}
                    <div class="atc_bundle__variant">{$astra_bundle->primary_variant->name|escape}</div>
                {/if}
                <div class="atc_bundle__unit_price">{$astra_bundle->primary_variant->price|convert} {$currency->sign|escape}</div>
            </div>
        </div>

        <div class="atc_bundle__plus" aria-hidden="true">+</div>

        <div class="atc_bundle__product">
            <a class="atc_bundle__image" href="{url_generator route='product' url=$astra_bundle->secondary_product->url}">
                {if $astra_bundle->secondary_product->image}
                    <img src="{$astra_bundle->secondary_product->image->filename|resize:120:120}" alt="{$astra_bundle->secondary_product->name|escape}" loading="lazy">
                {else}
                    <span class="atc_bundle__noimage">{include file='svg.tpl' svgId='no_image'}</span>
                {/if}
            </a>
            <div class="atc_bundle__product_info">
                <a class="atc_bundle__product_name" href="{url_generator route='product' url=$astra_bundle->secondary_product->url}">{$astra_bundle->secondary_product->name|escape}</a>
                {if $astra_bundle->secondary_variant->name}
                    <div class="atc_bundle__variant">{$astra_bundle->secondary_variant->name|escape}</div>
                {/if}
                <div class="atc_bundle__unit_price">{$astra_bundle->secondary_variant->price|convert} {$currency->sign|escape}</div>
            </div>
        </div>
    </div>

    <div class="atc_bundle__footer">
        <div class="atc_bundle__prices">
            <div class="atc_bundle__old_price">{$astra_bundle->regular_price|convert} {$currency->sign|escape}</div>
            <div class="atc_bundle__price_label">{$lang->Astra_together_cheaper__bundle_price|escape}</div>
            <div class="atc_bundle__price">{$astra_bundle->bundle_price|convert} {$currency->sign|escape}</div>
        </div>
        <button type="button"
                class="atc_bundle__button fn_atc_add"
                data-bundle-id="{$astra_bundle->id|intval}"
                data-route="{url_generator route='Astra_together_cheaper_add' absolute=1}"
                data-loading-text="{$lang->Astra_together_cheaper__adding|escape}"
                data-default-text="{$lang->Astra_together_cheaper__add|escape}"
                data-error-text="{$lang->Astra_together_cheaper__error|escape}"
                data-ga-price="{$astra_bundle->bundle_price|convert:null:false}"
                data-ga-primary-id="{$astra_bundle->primary_product->id|intval}"
                data-ga-primary-name="{$astra_bundle->primary_product->name|escape}"
                data-ga-primary-variant="{$astra_bundle->primary_variant->id|intval}"
                data-ga-secondary-id="{$astra_bundle->secondary_product->id|intval}"
                data-ga-secondary-name="{$astra_bundle->secondary_product->name|escape}"
                data-ga-secondary-variant="{$astra_bundle->secondary_variant->id|intval}"
                data-ga-primary-regular="{$astra_bundle->primary_variant->price|convert:null:false}"
                data-ga-secondary-regular="{$astra_bundle->secondary_variant->price|convert:null:false}">
            <span class="atc_bundle__button_text">{$lang->Astra_together_cheaper__add|escape}</span>
        </button>
    </div>
</div>
{/if}
