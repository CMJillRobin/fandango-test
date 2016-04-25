<!--- @@Description: Council Type --->
<!--- @@Developer: Connections Media --->
<cfcomponent name="StaffMember" extends="farcry.core.packages.types.versions" output="false" displayname="Staff Members">
<!------------------------------------------------------------------------
type properties
------------------------------------------------------------------------->	

<!--- START:  GENERAL DETAILS --->
<cfproperty ftSeq="1" ftwizardStep="Start" ftFieldset="General Details" name="Title" type="nstring" hint="Title of object.  *perhaps this should be deprecated for object label*" required="no" default="" ftValidation="required" displayname="Full Name" ftLabel="Full Name">

<cfproperty ftseq="5" ftwizardStep="Start" ftFieldset="General Details" name="LastName" type="nstring" displayname="Last Name" hint="Last name for alphabetical sorting" required="no" default="" ftValidation="required" ftLabel="Last Name (for sorting">

<cfproperty ftseq="7" ftwizardStep="Start" ftFieldset="General Details" name="ProfTitle" type="nstring" displayname="Professional Title" hint="CEO, etc." required="no" default="" ftLabel="Title used to describe position">

<cfproperty ftseq="9" ftwizardStep="Start" ftFieldset="General Details" name="Company" type="nstring" displayname="Company/Professional Affiliation" hint="XYZ Corp." required="no" default="" ftLabel="Name of Company or Organization">

<cfproperty ftseq="11" ftwizardStep="Start" ftFieldset="General Details" name="companyWebsite" type="nstring" displayname="Company Website" hint="http://www.xyzcorp.com." required="no" default="" ftLabel="Website">


<!--- START:  PUBLISH/REVIEW DATE --->
<cfproperty ftseq="21" 
    ftwizardStep="Start"
    ftFieldSet="Publish/Review Date" 
    name="publishDate" 
    type="date" 
    hint="Date item was published" 
    required="no" 
    default="" 
    ftType="datetime" 
    ftDateFormatMask="dd mmm yyyy" 
    ftTimeFormatMask="hh:mm tt" 
    ftToggleOffDateTime="false" 
    ftlabel="Publish Date" />


<cfproperty ftSeq="22" ftwizardStep="Start" ftFieldset="Publish/Review Date" name="reviewDate" type="date" hint="The date for which the object will be reviewed" required="no" default="" ftType="datetime" ftToggleOffDateTime="true" ftLabel="Review Date">

<!--- START:  OWNER --->

<cfproperty ftSeq="31" ftwizardStep="Start" ftFieldset="Owner" name="ownedby" displayname="Owned by" type="string" hint="Username for owner." required="No" default="" ftLabel="Owned By" ftType="list" ftRenderType="dropdown" ftListData="getOwners">

<!--- <cfproperty ftSeq="5" ftwizardStep="Start" ftFieldset="General Details" name="displayMethod" type="string" hint="Display method to render this HTML object with." required="yes" default="displayPageStandard" ftLabel="Display Method" ftType="webskin" ftPrefix="displayPage"> --->




<!--- TEASER:  teaser --->    
<cfproperty ftSeq="41" ftwizardStep="Teaser and Social Links" ftFieldset="Teaser" name="teaser" type="longchar" hint="Teaser text." required="no" default="" ftLabel="Teaser" />

<cfproperty ftSeq="42" ftwizardStep="Teaser and Social LInks" ftFieldset="Teaser" name="teaserImage" type="uuid" hint="UUID of image to display in teaser" required="no" default="" ftJoin="dmImage" ftLabel="Teaser Image" />





<!--- BODY --->    

<cfproperty
  name="aFileObjectIDs" type="array" hint="Associated Images" required="no" default=""
  ftSeq="60" ftwizardStep="Body" ftFieldset="Associated Images" ftLabel="Associated Images"
  ftType="array" ftJoin="dmImage" />



<cfproperty ftSeq="61" ftwizardStep="Body" ftFieldset="Body" name="body" type="longchar" hint="Main body of content." required="no" default="" ftType="richtext" ftLabel="Body" 
	ftImageArrayField="aObjectIDs" ftImageTypename="dmImage" ftImageField="StandardImage"
	ftTemplateTypeList="dmImage,dmFile,dmFlash,dmNavigation,dmHTML" ftTemplateWebskinPrefixList="insertHTML"
	ftLinkListRelatedTypenames="dmFile"
	ftTemplateSnippetWebskinPrefix="insertSnippet">



<!--- CATEGORISATION:  CATEGORIES --->
<cfproperty ftSeq="81" ftwizardStep="Categorisation" ftFieldset="Categories" name="catHTML" type="nstring" hint="Topic." required="no" default="" ftType="Category" ftAlias="root" ftLabel="Categories" />

<!--- CATEGORISATION:  METADATA --->
<cfproperty ftSeq="91" ftwizardStep="Categorisation" ftFieldset="Metadata" name="metaKeywords" type="nstring" hint="HTML head section metakeywords." required="no" default="" ftLabel="Meta Keywords">

<cfproperty ftSeq="92" ftwizardStep="Categorisation" ftFieldset="Metadata" name="extendedmetadata" type="longchar" hint="HTML head section for extended keywords." required="no" default="" ftlabel="Extended Metadata" ftToggle="true">


<!------------------------------------------------------------------------
object methods 
------------------------------------------------------------------------->	


    <cffunction name="getAllProfiles" access="public" output="false" returntype="query" hint="Gets all the profiles in dmProfile">
        <cfquery datasource="#application.dsn#" name="allProfiles">
            select		*
            from	 	#application.dbowner#dmProfile
 			order by lastName
 
        </cfquery>
		<cfreturn allProfiles />	    
    </cffunction>

<cffunction name="beforeSave" hint="Runs when the status changes" output="no" returntype="struct">
	<cfargument name="stProperties" required="true" type="struct">
 	<cfargument name="stFields" required="true" type="struct">
 	<cfargument name="stFormPost" required="false" type="struct">

	<cfset arguments.stProperties.label = arguments.stProperties.title>
 	
	<cfreturn arguments.stProperties />
</cffunction>

</cfcomponent>

