<cfcomponent 
	displayname="Staff Members: List selected" 
	extends="farcry.core.packages.rules.rules" 
	hint="Creates a list of the selected objects from staffMember">
	
	<cfproperty 
		name="ruleTitle" type="string" hint="title"
		ftseq="1" ftFieldset="Rule Configuration" ftLabel="Admin Title"
		fthint="Title used to identify the rule; this is not used in the content.">
		
	<cfproperty 
		name="aContent" type="array" hint="The selected items to be displayed." 
		ftSeq="3" ftFieldset="Rule Configuration" ftLabel="Content" 
		ftJoin="staffMember" />
	
</cfcomponent>
