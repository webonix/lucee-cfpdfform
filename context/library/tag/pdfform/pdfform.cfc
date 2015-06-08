component {

	VARIABLES.reader  = createObject("java","com.itextpdf.text.pdf.PdfReader",  "lib/itextpdf/5.5.6/itextpdf-5.5.6.jar");
	VARIABLES.stamper = createObject("java","com.itextpdf.text.pdf.PdfStamper", "lib/itextpdf/5.5.6/itextpdf-5.5.6.jar");

	public any function init()

	{
		VARIABLES.reader  = createObject("java","com.itextpdf.text.pdf.PdfReader",  "lib/itextpdf/5.5.6/itextpdf-5.5.6.jar");
		VARIABLES.stamper = createObject("java","com.itextpdf.text.pdf.PdfStamper", "lib/itextpdf/5.5.6/itextpdf-5.5.6.jar");

		return THIS;
	}

	public Struct function getFormFields
		(
			required string source
		)
	{

		var stFormFields = structNew("linked");
		var local = {};

		local.pdf = VARIABLES.reader.init(ARGUMENTS.source);

		local.pdfForm = local.pdf.getAcroFields();
		local.stFields = pdfForm.getFields().keySet().iterator();

		while (local.stFields.hasNext()) {
			var fieldName = stFields.next();
			stFormFields[fieldName] = pdfForm.getField(fieldName);
		}

		local.pdf.close();

		return stFormFields

	}

	public boolean function setFormFields
		(
			required string source,
			required string destination,
			required struct stFormFields,
			boolean overwrite = true
		)
	{
		var local = {};

		local.ok = true;

		local.pdf = VARIABLES.reader.init(ARGUMENTS.source);

		//local.writePDF = expandpath("#getTempDirectory()##createUUID()#.pdf");
		local.fileIO   = createObject("java","java.io.FileOutputStream").init(ARGUMENTS.destination);

		local.newPDF     = VARIABLES.stamper.init(local.pdf, local.fileIO);
		local.pdfFormNew = local.newPDF.getAcroFields();

		local.pdfForm = local.pdf.getAcroFields();
		local.stFields = pdfForm.getFields().keySet().iterator();

		// set field values
		// TODO: loop through ARGUMENTS['stFormFields'] (for now this ensures all fields are passed in)
		while (local.stFields.hasNext()) {
			var fieldName = stFields.next();
			
			if (StructKeyExists(ARGUMENTS['stFormFields'], fieldName)) {
				local.pdfFormNew.setField(fieldName, ARGUMENTS['stFormFields'][fieldName]);
			} else {
				// TODO: overwrite
			}
		}

		//local.newPDF.setFormFlattening(true); in CFPDF tag - flatten

		local.newPDF.close();
		local.pdf.close();
		local.fileIO.close();

		//local.binaryFile = fileReadBinary(local.writePDF);
		//fileDelete(local.writePDF);

		return local.ok

	}
}
