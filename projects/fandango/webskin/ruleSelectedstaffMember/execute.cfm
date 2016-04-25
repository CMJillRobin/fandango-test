<cfsetting enablecfoutputonly="true">
<!--- @@displayname: Display selected Staff Members items --->

<cfimport taglib="/farcry/core/tags/webskin" prefix="skin" />

<cfset oType = createObject("component",application.stCoapi.staffMember.packagePath)>

<cfloop from="1" to="#arraylen(stObj.aContent)#" index="i">
	<skin:view typename="staffMember" objectid="#stObj.aContent[i]#" webskin="displayTeaserStandard" />
</cfloop>

<cfsetting enablecfoutputonly="false">
