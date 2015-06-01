# lucee-cfpdfform
Tag for Lucee Server. Read and Populate PDF Form Fields

````cfml
<cftry>

	<cfset pdfForm = ExpandPath('./my-pdf-form.pdf')>
	<cfoutput><p>#pdfForm#</p></cfoutput>
	
	<cfpdfform action="read" source="#pdfForm#" result="stFormFields">
	<cfdump var="#stFormFields#" label="stFormFields">
	
	<hr>

	<cfpdfform action="populate" source="#pdfForm#" destination="#ExpandPath('./populated-pdf-form.pdf')#" >
		<cfpdfformparam name="Name"    value="ajm">
		<cfpdfformparam name="Account" value="webonix">
	</cfpdfform>

	<cfcatch>
		<cfdump var="#cfcatch#">
	</cfcatch>
</cftry>
````
