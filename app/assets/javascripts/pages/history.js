$(function() {
  $(".history .revision .expand-button").click(function(e) {
    $(this).parents(".revision").find(".changes").slideToggle();
    e.preventDefault();
  });

  $(".history .revision .changes").hide().eq(0).show();
});
