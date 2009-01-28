//Plugin to add text to an input field that disappears on focus (http://dabrook.org/blog/articles/input-field-hints-plugin-for-jquery)

jQuery.fn.inputFieldText = function(textIfEmpty, hintClass) {
	this.each(function() {
    if($(this).val() == '' || $(this).val() == textIfEmpty) {
      $(this).val(textIfEmpty);
      $(this).addClass(hintClass);
      $(this).focus(function() {
        $(this).val('');
        $(this).removeClass(hintClass);
      });
    }
  });
}
