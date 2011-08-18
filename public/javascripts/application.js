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

});
