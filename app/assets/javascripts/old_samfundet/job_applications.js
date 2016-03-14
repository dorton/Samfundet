function redrawPriorityColumn() {
  $(".sortable .priority").each(function (index) {
    $(this).html(index + 1 + '.');
  });
}

$(function () {
  $(".sortable .up, .sortable .down").submit(function (event) {
    event.preventDefault();
    var $row = $(this).parents("tr:first");

    if ($(this).is(".up")) {
      var $other = $row.prev();
      $row.insertBefore($other);
    } else {
      var $other = $row.next();
      $row.insertAfter($other);
    }

    $(".sortable").addClass("loading");
    var $swappedPriority = $row.add($other).find(".priority");
    $swappedPriority.html($("<img>").attr("src", "/assets/indicator.gif"));

    $.post($(this).attr("action"), $(this).serialize())
    .error(function () { $swappedPriority.html("FEIL"); })
    .success(function () {
        redrawPriorityColumn();
        $(".sortable").removeClass("loading");
    });
  });
});
