document.addEventListener("turbolinks:load", function() {

		
		$('#CreateReview').click( function(event) {

			
			if ($("#rating_element").val() == "" ) {
		    	
		    	event.preventDefault();
		    	window.alert("Rating couldn't be empty!");
			}
		});


$('.rating span').click(function(){
  			
  			var boundary= $(this).attr('value');
  			for(var i=1; i<= 5; i++ ) {
  				$('#star_'+i).css('color', '#A9A9A9');
  			}
  			for(var i=1; i<= boundary; i++ ) {
  				
  				$('#star_'+i).css('color', '#FFD700');
  			}

  			document.getElementById('rating_element').value= boundary;
		});
});