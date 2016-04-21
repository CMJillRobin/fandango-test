<cfoutput>

<h3>Hola!  Today is #dateFormat(now(),"mmmm dd, yyyy")#</h3>

<cfif isDefined("session.dmProfile")>
	<cfdump var="#session.dmProfile#">
</cfif>

<cfif isDefined("CGI")>
	<cfdump var="#CGI#">
</cfif>
    
</cfoutput>