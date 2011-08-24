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
      var inertia = 40000000.0 / distance;
      var height = $(window).height();
      var x = $(element).css("backgroundPosition").split(/\D/)[0];
 
console.log($(element).attr("class") + ": " + inertia);
      function new_position(pos) {
        return x + "% " + (-((height + pos) - (height + adjuster)) * inertia)  + "px";
      } 

      $(window).scroll(function(){
        var current_pos = $(window).scrollTop();
console.log($(element).attr("class") + ": " + new_position(current_pos));
        element.css("backgroundPosition", new_position(current_pos));
      });
    });
  };
})(jQuery);
