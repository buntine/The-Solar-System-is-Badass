$(document).ready(function(){
		   
  // Open external links in new tab/window
  $("a[href*='http://']:not([href*='"+location.hostname+"'])").click(function(){
    this.target = "_blank";
  });
    
  // Return inputs to default value on blur.
  $('input[alt]').focus(function(){
    if ($(this).attr("value") === $(this).attr("defaultValue")) {
      $(this).attr("value", "");
    }
  }).blur(function(){
    if ($(this).attr("value") === "") {
     $(this).attr("value", $(this).attr("defaultValue"));
    }
  });

  $("#overlay").click(function(){
    $(this).animate({opacity: 0}, 1000, function(){ $(this).hide();});
  });

  // Setup planets.
  setTimeout(function(){
    $(".planet").planet();
  }, 1000);

  // Navigation animations.
  $("#nav a").click(function(){
    $("html, body").animate({
      scrollTop: $($(this).attr("href") + "_section").offset().top - 70
    }, 1500);

    return false;
  });

});
