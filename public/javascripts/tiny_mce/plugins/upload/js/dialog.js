tinyMCEPopup.requireLangPack();

var UploadDialog = {
	init : function() { },

	insert : function() {
    var filename = document.forms[0].filename.value;
    var alt = document.forms[0].alt.value;
    var image_tag = "<img src='" + filename + "' alt='" + alt + "' />";
		tinyMCEPopup.editor.execCommand('mceInsertContent', false, image_tag);
		tinyMCEPopup.close();
	}
};

tinyMCEPopup.onInit.add(UploadDialog.init, UploadDialog);
