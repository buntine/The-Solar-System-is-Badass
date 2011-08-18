jQuery.noConflict();

// Plots the traffic to this website, given an array of points.
// Because JS passes objects by-reference to functions, I create an 
// identical date to pass to generateTicks in order to preserve the
// original value for the plothover closure.
// I've packaged this functionality up as a JQuery plugin.
(function($) {
  $.fn.plotTraffic = function(date_parts, data) {
    var start_date = new Date(date_parts[0], (date_parts[1] - 1), date_parts[2]);

    $.plot($(this), data,
           {points: {show: true},
            lines: {show: true},
            xaxis: {ticks: generateTicks(new Date(start_date.toUTCString())),
                    max: 30},
            grid: {hoverable: true, clickable: true,
                   backgroundColor: {colors: ["#ffffff", "#cccccc"]}}});

    // Generates and displays a tooltip on hover.
    $(this).bind("plothover", function(e, pos, item) {
      if (item) {
        var plot_date = new Date(start_date.toUTCString());
        var traffic = item.datapoint[1];
        plot_date.setDate(plot_date.getDate() + (item.datapoint[0] - 30));

        $("#tooltip").remove();
        generateTooltip(item.pageX, item.pageY, plot_date, traffic);
      } else {
        $("#tooltip").remove();
      }
    });

    return false;
  }

  // Returns an array representing the ticks for the X-axis of the graph.
  // Each Sunday should be 'ticked' going back for 30 days.
  function generateTicks(start_date) {
    var ticks = [];

    for (var i=0; i<30; i++) {
      if (start_date.getDay() === 0) {
        ticks.push([(30 - i), formatDate(start_date)]);
      }
      start_date.setDate(start_date.getDate() - 1);
    }

    return ticks;
  }

  // Formats a date as "Mon nn".
  function formatDate(dte) {
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return months[dte.getMonth()] + " " + dte.getDate().toString();
  }

  // Generates a tooltip for the given date and traffic.
  function generateTooltip(x, y, plot_date, traffic) {
    content = formatDate(plot_date) + ": " + traffic + " visits";
    $('<div id="tooltip">' + content + '</div>').css({
      position: 'absolute',
      display: 'none',
      top: y + 5,
      left: x + 5,
      border: '1px solid #fdd',
      padding: '2px',
      'background-color': '#fee',
      opacity: 0.80
    }).appendTo("body").fadeIn(200);
  }
})(jQuery);
