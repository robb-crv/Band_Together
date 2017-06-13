document.addEventListener("turbolinks:load", function() {

  $.getJSON('/notifications#index'  , function(data){
    $('#txtUnreadQty').empty();
    $('#pnlNotifications').empty();
    var qty = 0;
    $.each(data, function(recipient,actor,read,action,notifiable){
      var opt = '<li>' + actor + ' </li>';
      $('#pnlNotifications').append(opt);
      qty = qty +1;
    });
    $('#txtUnreadQty').text(qty);




  });

});
