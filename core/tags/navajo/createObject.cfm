<!--- @@Copyright: Daemon Pty Limited 2002-2008, http://www.daemon.com.au --->
<!--- @@License:
    This file is part of FarCry.

    FarCry is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    FarCry is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with FarCry.  If not, see <http://www.gnu.org/licenses/>.
--->
<!---
|| VERSION CONTROL ||
$Header: /cvs/farcry/core/tags/navajo/createObject.cfm,v 1.20 2005/09/02 06:27:37 guy Exp $
$Author: guy $
$Date: 2005/09/02 06:27:37 $
$Name: milestone_3-0-1 $
$Revision: 1.20 $

|| DESCRIPTION || 
$Description: creates an instance of an type object and returns to edit handler$
$TODO: make more generic. There is some type specific code here for defaulting properties. Should build instance by using type specified fields/defaults$

|| DEVELOPER ||
$Developer: Brendan Sisson (brendan@daemon.com.au)$
$Developer: Paul Harrison (harrisonp@cbs.curtin.edu.au)$

|| ATTRIBUTES ||
$in: $
$out:$
--->

<cfsetting enablecfoutputonly="Yes">

<cfprocessingDirective pageencoding="utf-8">

<cfimport taglib="/farcry/core/packages/fourq/tags/" prefix="q4">
<cfimport taglib="/farcry/core/tags/navajo/" prefix="nj">
<cfinclude template="/farcry/core/webtop/includes/utilityFunctions.cfm">


<cfparam name="url.objectId" default="">
<cfparam name="url.nodetype" default="dmNavigation">

<cfif NOT isDefined("URL.typename")>
	<h3>URL.typename variable not provided</h3>
	<cfabort>
</cfif>

<cfif len(url.objectId)>
	<q4:contentobjectget  objectid="#url.objectId#" bactiveonly="False" r_stobject="stParent">
	<!--- permission check for objects --->
	<nj:getNavigation objectId="#stParent.objectID#" bInclusive="1" r_stObject="bob" r_ObjectId="objectId">
	
	<Cfif len(objectId)>
		<cfset parentNavigationId=objectId>
	</CFIF>
	
<cfelse>
	<cfset temp=1>
</cfif>

<!--- make sure parent can hold an object before doing anything... --->	
<cfif len(url.objectId) AND not structKeyExists(stParent,"aObjectIds")>
	<cfoutput>
		#application.rb.getResource('workflow.messages.noaobjectids@text',"You cannot create an item inside this content item as it has no aObjectIds property.")#
	</cfoutput>
	<cfabort>

<cfelse>	
	<!--- default properties --->
	<cfscript>
		stProps=structNew();
		stProps.objectid = application.fc.utils.createJavaUUID();
		stProps.label = "(incomplete)";
		stProps.title = "";
		stProps.lastupdatedby = application.security.isLoggedIn();
		stProps.datetimelastupdated = Now();
		stProps.createdby = application.security.isLoggedIn();
		stProps.datetimecreated = Now();

		// dmHTML specific props
		stProps.displayMethod = "display";
		stProps.status = "draft";
		//dmNews specific props
		stProps.publishDate = now();
		stProps.expiryDate = now();
		
		oType = createobject("component", application.types[url.typename].typePath);
		stNewObj = oType.createData(stProperties=stProps);
		NewObjId = stNewObj.objectid;
	</cfscript>

			
	<!--- update parent object  --->
	<cfif len(url.objectId) AND not (arraytolist(stParent.aObjectIds) contains NewObjID)>
	
		<cfif url.typename IS url.nodetype>
			
			<cfif NOT stParent.typename IS url.nodetype>
				<cfoutput><b>#application.rb.getResource('workflow.messages.cantcreatenavobject@text',"Cannot create navigation nodes in content items!")#</b></cfoutput>
				<cfabort>
			<cfelse>
				<!--- Insert this node into the tree --->
				<cfscript>
					qChildren = application.factory.oTree.getChildren(objectid=stParent.objectID,typename=stParent.typename);
					position = qChildren.recordCount + 1;
					streturn = application.factory.oTree.setChild(objectName=stProps.label,typename=typename,parentID=stParent.objectID,objectID=newObjId,pos=position);
				</cfscript>

			</cfif>
		<cfelse>
			<!--- Append new ObjectIDs to AObjects array --->
			<cfscript>
				arrayAppend(stParent.aObjectIds, NewObjID);
				stParent.DATETIMECREATED =  createODBCDate("#datepart('yyyy',stParent.DATETIMECREATED)#-#datepart('m',stParent.DATETIMECREATED)#-#datepart('d',stParent.DATETIMECREATED)#");
				stParent.DATETIMELASTUPDATED = createODBCDate(now());
				oParentType = createobject("component", application.types[stParent.typename].typePath);
				oParentType.setData(stProperties=stParent);
			</cfscript>
			
		</cfif>
		
	</cfif>
	
	<!--- Now that we know its type and new objectID go and edit the object now --->
	<cfscript>
		st = filterStructure(URL,'objectid,nodetype');
		queryString=structToNamePairs(st);
	</cfscript>
	<cfoutput>
		<script type="text/javascript">
			window.location="#application.url.farcry#/navajo/edit.cfm?objectId=#NewObjID#&#queryString#";
		</script>
	</cfoutput>
	
</cfif>

<cfsetting enablecfoutputonly="No">