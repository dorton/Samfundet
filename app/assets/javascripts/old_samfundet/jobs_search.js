$(function(){
  $('#job-search-query input').autocomplete({source: function(request, response){
      $.ajax({
        url: "search",
        data: {q: request.term},
        dataType: "json",
        success: function(data){
          response($.map(data, function(item){
            return {
              label: item.title_no + " - " + item.admission,
              value: item.title_no,
              title_no: item.title_no,
              title_en: item.title_en,
              teaser_no: item.teaser_no,
              teaser_en: item.teaser_en,
              description_no: item.description_no,
              description_en: item.description_en,
              is_officer: item.is_officer,
              tag_titles: item.tag_titles
            };
          }));
        }
      });
  }, select: function(event, ui){
    $('#job_title_no').val(ui.item.title_no);
    $('#job_title_en').val(ui.item.title_en);
    $('#job_teaser_no').val(ui.item.teaser_no);
    $('#job_teaser_en').val(ui.item.teaser_en);
    $('#job_description_no').val(ui.item.description_no);
    $('#job_description_en').val(ui.item.description_en);
    $('#job_is_officer').attr('checked', ui.item.is_officer);
    $('#job_tag_titles').val(ui.item.tag_titles);
  }, close: function(event, ui){
    $('#job-search-query input').val('');
  }});
});
