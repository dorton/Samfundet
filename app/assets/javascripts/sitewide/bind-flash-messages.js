$(function() {
  // Only success-messages should be auto-hidden.
  // We do not want to  hide important messages.
  var delay_before_hide_flash_messages = 4000; // ms
  $('.flash.success').delay(delay_before_hide_flash_messages).slideUp(1000);
});
