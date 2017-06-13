document.addEventListener("turbolinks:load", function() {
      $("a.page-scroll").bind("click",function(e){
        var t=$(this);
        $("html, body").stop().animate({
          scrollTop:$(t.attr("href")).offset().top},1500,"easeInOutExpo"),e.preventDefault()
        })
      });
