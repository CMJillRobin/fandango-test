<cfsetting enablecfoutputonly="yes">
<!--- @@displayname: Standard Teaser for staffMember --->
<!--- @@author: Scaffold--->

<!--- tag libraries --->
<cfimport taglib="/farcry/core/tags/webskin/" prefix="skin">
<cfimport taglib="/farcry/core/tags/formtools/" prefix="ft">

<cfoutput>
<div class="teaser">
	<h4>#stObj.label#</h4>
</cfoutput>
	
	<ft:object stObject="#stobj#" lFields="teaser" format="display" />
	
	<cfoutput><div></cfoutput>
		<skin:buildLink objectID="#stObj.ObjectID#"><cfoutput>more...</cfoutput></skin:buildLink>
	<cfoutput>
	</div>
</div>
</cfoutput>

<cfsetting enablecfoutputonly="false" />
