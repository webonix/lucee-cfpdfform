# lucee-cfpdfform
Tag for Lucee Server. Read and Populate PDF Form Fields

still a Work in Progress.
Please add comments/suggestions and raise any issues you discover.

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
## iText
I am not sure if the license allows for distribution, so download from
https://github.com/itext/itextpdf/releases
and save to
/context/library/tag/pdfform/lib/itextpdf/5.5.6/

## Lucee
- Save to Lucee context directory
- you will need to restart Lucee when you have added these files (and after editting a tag)
