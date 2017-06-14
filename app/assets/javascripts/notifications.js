document.addEventListener("turbolinks:load", function() {

  $.getJSON('/notifications.json'  , function(data){
    $('#txtUnreadQty').empty();
    $('#pnlNotifications').empty();
    var qty = 0;

    $.each(data.notifications, function(k,ele){
      var opt = '<li > <a data-method="get" href="' + ele.url  + '">' + ele.etichetta + '</a> </li>';
      $('#pnlNotifications').append(opt);
      qty = qty +1;
    });


    var opt = '<li role="separator" class="divider"></li>'
    opt += '<li style="display:table;margin:0px auto 0px auto;">'
    opt += '  <form class="button_to" method="get" action="/notifications"><input class="btn btn-primary" type="submit" value="Show All" /></form> '
    opt += '</li>'

    $('#pnlNotifications').append(opt);

    if(qty > 0)
        $('#txtUnreadQty').text(qty);

  });

});
