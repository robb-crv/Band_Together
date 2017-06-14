document.addEventListener("turbolinks:load", function() {

  $.getJSON('/notifications.json'  , function(data){
    $('#txtUnreadQty').empty();
    $('#pnlNotifications').empty();
    var qty = 0;

    $.each(data, function(k,ele){
      var opt = '<li>' + ele.action + ' </li>';
      $('#pnlNotifications').append(opt);
      qty = qty +1;
    });
    if(qty > 0)
        $('#txtUnreadQty').text(qty);




  });

});
