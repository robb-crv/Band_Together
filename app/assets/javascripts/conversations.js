document.addEventListener("turbolinks:load", function() {

    $('.chosen-select').chosen({
        no_results_text: 'No results matched'
    });




      $('#cmbDestinatari').change(function(){

          if($('#cmbDestinatari').val() != null){
          //  $('#cmbBandDestinatari').val('');
        //    $('#cmbBandDestinatari').selectpicker('refresh');
            $('#cmbBandDestinatari').prop('disabled', true);
          }else{
              $('#cmbBandDestinatari').prop('disabled', false);
          }

        });


          $('#cmbBandDestinatari').change(function(){
            if($('#cmbBandDestinatari').val() != ''){
            //  $('#cmbDestinatari').val(null);
              $('#cmbDestinatari').prop('disabled', true).trigger("chosen:updated");
            }else{
                $('#cmbDestinatari').prop('disabled', false).trigger("chosen:updated");
            }
          });


          $('#btnCreateConversation').click(function(evt){
              if($('#cmbBandDestinatari').val() == '' && $('#cmbDestinatari').val() == null){
                  alert('Please choose the receiver of this message, they could be members of your bands or your contacts');
                  evt.preventDefault();
              }
          });



});



function filterBands(event,elemento){
      selected_id = elemento.value;

      if(selected_id != ""){
        window.location.href = '/mailbox/inbox?selected_band_id=' + selected_id;
      }else{
          window.location.href = '/mailbox/inbox';
      }

};








function untrashItem(event,itemId) {
    event = event || window.event;
    event.preventDefault();

    if(confirm('Do you want to restore conversation?')){
      $.ajax({
          type: 'POST',
          url: "/conversations/"+itemId+"/untrash"
        });


    }



    return false;

};

function trashItem(event,itemId) {
  event = event || window.event;
  event.preventDefault();
  if(confirm('Do you want to move to trash conversation?')){
    $.ajax({
        type: 'POST',
        url: "/conversations/"+itemId+"/trash"
      });
  }
  return false;

};
