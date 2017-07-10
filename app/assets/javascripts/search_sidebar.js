document.addEventListener("turbolinks:load", function() {
	$('#user_musical_genre_id').change(function(){
		var select_value = $(this).val();
		$('#musical_genre_id').val(select_value);
	});

	$('#user_type_of_musician_id').change(function(){
		var select_value = $(this).val();
		$('#type_of_musician_id').val(select_value);
	});
});