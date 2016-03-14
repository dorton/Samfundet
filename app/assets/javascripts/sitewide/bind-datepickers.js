$(function() {
  $.datepicker.setDefaults({dateFormat: 'dd.mm.yy', defaultDate: +0, showWeek: true});
  $('.datetimepicker').datetimepicker();
  $('.datetimepicker_lyche').datetimepicker({hourMin: 16, hourMax: 22, stepMinute: 15});
  $('.datepicker').datepicker();
});
