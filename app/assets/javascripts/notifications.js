document.addEventListener("turbolinks:load", function() {

  $.getJSON('/notifications.json'  , function(data){
    $('#txtUnreadQty').empty();
    $('#pnlNotifications').empty();
    var qty = 0;

    var opt = "";

    $.each(data.notifications, function(k,ele){
      if(ele.is_read){
        var mOpt = '<li > <a class="list-group-item list-group-item-action" data-method="get" href="' + ele.url  + '">' + ele.etichetta + '    <br/><small class="text-muted"><span class="glyphicon glyphicon-time"></span> ' + ele.created_at + '</small></a> </li>';

      }
      else {
        var mOpt = '<li > <a class="list-group-item list-group-item-info" data-method="get" href="' + ele.url  + '">' + ele.etichetta + '   <br/><small class="text-muted"><span class="glyphicon glyphicon-time"></span> ' + ele.created_at + '</small></a> </li>';
            qty = qty +1;
      }

      opt = mOpt + opt


    });


    $('#pnlNotifications').append(opt);


    if(qty > 0)
        $('#txtUnreadQty').text(qty);

  });



  $("#btnNotificationsDrpdown").click(function(){
    $.ajax({
        type: 'POST',
        url: "/notifications/mark_as_read"
      });

  });

});
