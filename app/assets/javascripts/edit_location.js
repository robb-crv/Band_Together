
document.addEventListener("turbolinks:load", function() {
      //Andrea. ho scelto di usare il trigger dell'evento di change della select dipendente da quella che si cambia, così
        //      ad ogni cambio di select a monte corrisponde un cambio a valle, eliminando il trigger non funzionava.

       // al cambio di nazione
        $('#countries').change(function(){


          $("#user_nation").val(""); //Setta il value del campo hidden nation al valore selezionato nella select "nation"

 //andrea. questo script viene usato anche dalla view di band new, perciò riempie tutti e due i campi, uno non lo troverà
          $("#band_nation").val("");


          //interroga la gemma per prendere le regioni corrispondenti
          $.getJSON('/states/' + $(this).val() , function(data){


                      $('#states-of-country').empty();
                      $('#city-of-region').empty();

            $.each(data, function(k, ele){
              var opt = '<option value='+ k +'>' + ele + '</option>';
              $('#states-of-country').append(opt);
            });





            $("#user_nation").val($('#countries').find(":selected").text()); //Setta il value del campo hidden nation al valore selezionato nella select "nation"

   //andrea. questo script viene usato anche dalla view di band new, perciò riempie tutti e due i campi, uno non lo troverà
            $("#band_nation").val($('#countries').find(":selected").text());

          //$("#user_region").val($('#states-of-country').find(":selected").text()); //Setta il value del campo hidden region al primo valore selezionato nella select "region"

              $("#states-of-country").trigger('change');
          });
        });


        // al cambio di regione
        $('#states-of-country').change(function(){


            $("#user_region").val("");
            $("#band_region").val("");

          //interroga la gemma per prendere le città corrispondenti
          $.getJSON('/states/' + $('#countries').val()  + '/' +  $(this).val() , function(data){

              $('#city-of-region').empty();
            $.each(data, function(k, ele){

              var opt = '<option value='+ k +'>' + ele + '</option>';
              $('#city-of-region').append(opt);
            });

            $("#user_region").val($('#states-of-country').find(":selected").text());
            $("#band_region").val($('#states-of-country').find(":selected").text());
          //$("#user_city").val($(this).find(":selected").text());
            $("#city-of-region").trigger('change');


        });


      });

        //al cambio di città
        $('#city-of-region').change(function(){
          $("#user_city").val($(this).find(":selected").text());
          $("#band_city").val($(this).find(":selected").text());

          console.log($("#band_city").val());
          console.log($("#band_region").val());
          console.log($("#band_nation").val());
        });
});
