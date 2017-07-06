document.addEventListener("turbolinks:load", function() {
   $('#UserCalendar').empty();
    $('#UserCalendar').fullCalendar(
      {

           // put your options and callbacks here
           events: '/users/events',
           height: 410,
           eventMouseover: function(event, jsEvent, view) {
             //alert(event.description);
             $(this).popover({html:true,title: "<b>" + event.title + "</b>",content:
                  "<strong>Band:</strong> " + event.band +"<br/>" +
                    "<strong>Description:</strong> " + event.description +"<br/>" +
                    "<strong>Location:</strong> " + event.location + "<br/>" +
                      "<strong>Start At:</strong> " + event.hours,
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
