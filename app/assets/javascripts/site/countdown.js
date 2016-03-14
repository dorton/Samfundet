$(function() {
  var countdown_to = new Date(2015, 3, 20, 10, 0, 0, 0).getTime();
  var time_now = new Date().getTime();
  if (time_now >= countdown_to) {
    $(".countdown-unit h2").text("Konsertene er sluppet!");
    $(".countdown-unit .time-left").remove();
    return;
  }

  updateCountdown();
  setInterval(updateCountdown, 1000);

  function updateCountdown() {
    var time_left = (countdown_to - time_now) / 1000;

    if (time_now > countdown_to) {
      window.location.reload();
    }

    time_now = new Date().getTime();
    var days_left = Math.floor(time_left/(3600*24));
    time_left %= (3600*24);
    var hours_left = Math.floor(time_left/3600);
    time_left %= 3600;
    var minutes_left = Math.floor(time_left/60);
    time_left %= 60;
    var seconds_left = time_left | 0;

    $(".time-left .days").html(days_left)
    $(".time-left .hours").html(hours_left)
    $(".time-left .minutes").html(minutes_left)
    $(".time-left .seconds").html(seconds_left)
  }
});
