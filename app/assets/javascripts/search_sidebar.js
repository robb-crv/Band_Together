var first_load = true;

function init_sidebar(){
	// Funzioni per la sidebar dei filtri della ricerca sull'utente
	
	$('.slider').slider();

	$('#user_musical_genre_id').change(function(){
		var select_value = $(this).val();
		$('#musical_genre_id').val(select_value);
	});

	$('#user_type_of_musician_id').change(function(){
		var select_value = $(this).val();
		$('#type_of_musician_id').val(select_value);
	});

  	$('#age').change(function(){
		var slider_value = $('#age').val();
		$('#selected_age').val(slider_value);
	});		

	// Funzioni per la sidebar dei filtri della ricerca sugli ads

	$('#ads_musical_genre_id').change(function(){
		var select_value = $(this).val();
		$('#band_genre_id').val(select_value);
	});

	console.log(first_load);	
} 

