//Plugin to add text to an input field that disappears on focus (http://dabrook.org/blog/articles/input-field-hints-plugin-for-jquery)

jQuery.fn.inputFieldText = function(search_term, default_text) { 			
	this.each(function() {
		if (search_term){
			$(this).val(search_term);
		}
		else {
			$(this).val(default_text);
			$(this).addClass('søke_hint');
		}
		$(this).focus(function(){
			if ($(this).val() == default_text){
				$(this).val('');
				$(this).removeClass('søke_hint');
			}
		});	
    });
}	
