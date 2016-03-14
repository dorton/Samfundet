$("#content.pages.edit").ready(function(){
  function update_preview(editor_id, preview_id, url) {
    if($(preview_id).is(":hidden")) {
      return;
    }

    $.post(
      url,
      {
        content: $(editor_id).val(),
        content_type: $("#page_content_type").val()
      }
    ).then(function(data, textStatus, xhr) {
        $(preview_id).html(data);
    });
  }

  function setup_preview(editor_id, preview_id, url) {
    if($(editor_id).length == 0 || $(preview_id).length == 0)
      return;

    var timer = null;

    $(editor_id).keyup(function(e) {
      clearTimeout(timer);
      timer = setTimeout(function(){
        update_preview(editor_id, preview_id, url);
      }, 1000);
    });

    $("#page_content_type").change(function(e) {
      update_preview(editor_id, preview_id, url);
    });

    update_preview(editor_id, preview_id, url);
  }

  setup_preview("#page_content_no", "#content_preview_no", "/informasjon/preview/");
  setup_preview("#page_content_en", "#content_preview_en", "/en/information/preview/");
});
