document.addEventListener("turbolinks:load", function() {
   $('#calendar').empty();
    $('#calendar').fullCalendar(
      {

           // put your options and callbacks here
           events: '/activities?id=' + $("#showed_band_id").val(), // showed_band_id is defined in band/show.html.erb
           height: 410,
           eventMouseover: function(event, jsEvent, view) {
             //alert(event.description);
             $(this).popover({html:true,title: "<b>" + event.title + "</b>",content:
                    "<strong>Description:</strong> " + event.description +"<br/>" +
                    "<strong>Location:</strong> " + event.location + "<br/>" +
                      "<strong>Start At:</strong> " + event.hours + "<br/>" +
                     event.accessibility + " Event" ,
                    placement:'top',container:'body'}).popover('show');
           },
           eventMouseout: function (event, jsEvent, view ){
             $(this).popover('hide');
           },
           eventClick: function(event, jsEvent, view) {
             $(this).popover('hide');
           }


       }

     );


    $("#share_on_fb").click(function(){
         window.open('https://www.facebook.com/dialog/feed?app_id=625050674363213&quote=Just%20discovered%20an%20amazing%20band%20please%20join%20to%20Band%20Together%20and%20see%20similar%20bands%20and%20other%20musicians&link=https%3A%2F%2Fwww.facebook.com%2Fbandtogetherofficial&hashtag=%23BandTogether', 'fbShareWindow', 'height=450, width=550, top=' + ($(window).height() / 2 - 275) + ', left=' + ($(window).width() / 2 - 225) + ', toolbar=0, location=0, menubar=0, directories=0, scrollbars=0');
    });

 });
