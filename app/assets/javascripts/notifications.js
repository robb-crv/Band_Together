document.addEventListener("turbolinks:load", function() {

  $.getJSON('/notifications.json'  , function(data){
    $('#txtUnreadQty').empty();
    $('#pnlNotifications').empty();
    var qty = 0;

    var opt = '<li role="separator" class="divider"></li>'
    opt += '<li style="display:table;margin:0px auto 0px auto;">'
    opt += '  <form class="button_to" method="get" action="/notifications"><input class="btn btn-primary" type="submit" value="Show All" /></form> '
    opt += '</li>'

    $.each(data.notifications, function(k,ele){
      if(ele.is_read){
        var mOpt = '<li > <a data-method="get" href="' + ele.url  + '">' + ele.etichetta + '    <br/><small>' + ele.created_at + '</small></a> </li>';

      }
      else {
        var mOpt = '<li > <a style="color: #57b266 !important;" data-method="get" href="' + ele.url  + '">' + ele.etichetta + '   <br/><small>' + ele.created_at + '</small></a> </li>';
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
