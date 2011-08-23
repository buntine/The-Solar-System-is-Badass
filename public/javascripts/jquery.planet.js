// planet.js
// Andrew Buntine, v0.1
// August, 2011
//
// Represents a planet in a solar-system. Part of a simple demonstration of the parallax effect.

(function($){
  $.fn.planet = function(){
    return this.each(function(){
      var element = $(this);
      var adjuster = parseInt(element.attr("data-adjust"));
      var distance = parseFloat(element.attr("data-distance"));
      var threshold = 40000000.0;
      var window_height = $(window).height();
      var speed = threshold / distance;
 
      function newPos(x, height, pos, adjuster, inertia) {
        return x + "% " + (-((height + pos) - (height + adjuster)) * inertia)  + "px";
      } 

      $(window).scroll(function(){
        var current_pos = $(window).scrollTop();
        var new_pos = newPos(element.attr("data-x"), window_height, current_pos, adjuster, speed);

        element.css("backgroundPosition", new_pos);
      });
    });
  };
})(jQuery);
