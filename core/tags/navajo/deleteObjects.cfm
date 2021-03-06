<cfsetting enablecfoutputonly="yes">
<cfprocessingDirective pageencoding="utf-8">
<cfimport taglib="/farcry/core/packages/fourq/tags/" prefix="q4">
<!--- deleteObjects.cfm

Description : 

Deletes single/multiple objects of a particular type. 
Intended for use with daemon dynamic data.

 --->

<cfparam name="attributes.lObjectIDs" default=""> <!--- The list of objects to be deleted - required--->
<cfparam name="attributes.typename" default=""> <!--- the type of object to be deleted - required --->
<cfparam name="attributes.rMsg" default="msg"> <!--- The message returned to the caller - optional --->


<cfif len(attributes.lObjectIDs) eq 0>
	<cfset "caller.#attributes.rMsg#" = "#application.rb.getResource('workflow.messages.noobjectselectedfordeletion@text','No content items were selected for deletion')#">
	<cfexit>
<cfelse>
	<!--- Now loop through the list and delete object --->
	<cfloop list="#attributes.lObjectIDs#" index="i">
		<q4:contentobjectdelete objectID="#i#">
	</cfloop>
	<cfset "caller.#attributes.rMsg#" = application.rb.formatRBString('workflow.messages.objectsDeleted@text',listLen(attributes.lObjectIds),'{1} content item(s) deleted') /> 
</cfif>