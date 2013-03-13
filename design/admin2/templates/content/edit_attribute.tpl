{* DO EDITING WITH TABS, INSTEAD OF THE DUMB ACCORDION *}
	{literal}
	<script type="text/javascript">
		function nextTab(button){
			button.closest('div.tab-block').find('li.selected').next('li').find('a').click();
			$('html, body').animate({scrollTop:$('div.tab-block').offset().top}, 500);
		}
		function prevTab(button){
			button.closest('div.tab-block').find('li.selected').prev('li').find('a').click();
			$('html, body').animate({scrollTop:$('div.tab-block').offset().top}, 500);
		}
	</script>
	{/literal}
{default $view_parameters            = array()
         $attribute_categorys        = ezini( 'ClassAttributeSettings', 'CategoryList', 'content.ini' )
         $attribute_default_category = ezini( 'ClassAttributeSettings', 'DefaultCategory', 'content.ini' )}

{def $numberCategories = $attribute_default_category|count()}
{def $tabCounter = 0}
{def $numTabs = 0}
<div class="tab-block" >
	<ul class="tabs">
{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
	{set $tabCounter = $tabCounter|inc()}
	{set $numTabs = $numTabs|inc()}
		<li id="node-tab-{$attribute_group}" class="{if eq($tabCounter, 1)}first selected{elseif eq($tabCounter, $numberCategories)}last{/if}">
			<a href="/(tab)/{$attribute_group}/" title="{$attribute_categorys[$attribute_group]}">{$attribute_categorys[$attribute_group]}</a>
		</li>
{/foreach}
	</ul>
	<div class="float-break"></div>
{* now do individual tabs contents *}
{def $tabCounter = 0}
{foreach $content_attributes_grouped_data_map as $attribute_group => $content_attributes_grouped}
	{set $tabCounter = $tabCounter|inc()}
	<div id="node-tab-{$attribute_group}-content" class="tab-content {if eq($tabCounter, 1)}selected{else}hide{/if}" style="height:auto; overflow-y: auto;">
	{foreach $content_attributes_grouped as $attribute_identifier => $attribute}
		{def $contentclass_attribute = $attribute.contentclass_attribute}
		<div class="block ezcca-edit-datatype-{$attribute.data_type_string} ezcca-edit-{$attribute_identifier}">
		{* Show view GUI if we can't edit, otherwise: show edit GUI. *}
		{if and( eq( $attribute.can_translate, 0 ), ne( $object.initial_language_code, $attribute.language_code ) )}
		    <label>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
		        {if $attribute.can_translate|not} <span class="nontranslatable">({'not translatable'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
		        {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
		    </label>
		    {if $is_translating_content}
		        <div class="original">
		        {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		        </div>
		    {else}
		        {attribute_view_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		        <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		    {/if}
		{else}
		    {if $is_translating_content}
		        <label{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
		            {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
		            {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
		            {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
		        </label>
		        <div class="original">
		        {attribute_view_gui attribute_base=$attribute_base attribute=$from_content_attributes_grouped_data_map[$attribute_group][$attribute_identifier] view_parameters=$view_parameters}
		        </div>
		        <div class="translation">
		        {if $attribute.display_info.edit.grouped_input}
		            <fieldset>
		            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		            </fieldset>
		        {else}
		            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		        {/if}
		        </div>
		    {else}
		        {if $attribute.display_info.edit.grouped_input}
		            <fieldset>
		            <legend{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
		                {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
		                {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
		                {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
		            </legend>
		            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		            </fieldset>
		        {else}
		            <label{if $attribute.has_validation_error} class="message-error"{/if}>{first_set( $contentclass_attribute.nameList[$content_language], $contentclass_attribute.name )|wash}
		                {if $attribute.is_required} <span class="required">({'required'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}
		                {if $attribute.is_information_collector} <span class="collector">({'information collector'|i18n( 'design/admin/content/edit_attribute' )})</span>{/if}:
		                {if $contentclass_attribute.description} <span class="classattribute-description">{first_set( $contentclass_attribute.descriptionList[$content_language], $contentclass_attribute.description)|wash}</span>{/if}
		            </label>
		            {attribute_edit_gui attribute_base=$attribute_base attribute=$attribute view_parameters=$view_parameters}
		            <input type="hidden" name="ContentObjectAttribute_id[]" value="{$attribute.id}" />
		        {/if}
		    {/if}
		{/if}
		</div>
		{undef $contentclass_attribute}
	{/foreach}
	{if ne($numTabs, 0)}

		<div>

			{if ne($tabCounter, 1)}<input type="button" onclick="prevTab($(this));" class="button" value="<< Previous Tab"/>{/if}
			{if ne($tabCounter, $numTabs)}<input type="button" onclick="nextTab($(this));" class="button" value="Next Tab >>"/>{/if}
		</div>
	{/if}
	</div>
{/foreach}
</div>

{ezscript_require( 'node_tabs.js' )}