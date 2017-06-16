document.addEventListener("turbolinks:load", function() {

    $('.chosen-select').chosen({
        no_results_text: 'No results matched'
    });



});






function untrashItem(itemId) {
    window.event.preventDefault();
    if(confirm('Do you want to restore conversation?')){
      $.ajax({
          type: 'POST',
          url: "/conversations/"+itemId+"/untrash"
        });


    }





};

function trashItem(itemId) {
  window.event.preventDefault();
  if(confirm('Do you want to move to trash conversation?')){
    $.ajax({
        type: 'POST',
        url: "/conversations/"+itemId+"/trash"
      });
  }

};
