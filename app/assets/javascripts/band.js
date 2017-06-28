document.addEventListener("turbolinks:load", function() {
   $('#calendar').empty();
    $('#calendar').fullCalendar(
      {

           // put your options and callbacks here
           events: '/activities?id=' + $("#showed_band_id").val(), // showed_band_id is defined in band/show.html.erb
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

 });
