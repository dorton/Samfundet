$(function() {
    bind_search('.images-search-form',
        '.images-search-form #search',
        '.existing-results',
        '.ajax-results');

    $(document).on('click', '.tag-list .tag', function (event) {
        event.preventDefault();
        var tag = $(this).data('tag');
        $(".images-search-form #search")
            .val(tag)
            .trigger('keyup');
    });
});
