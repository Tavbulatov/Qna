$(document).on('turbolinks:load', function(){
  let gistsUrl = $('.links').data('gists_url')
  let gistsId = $('.links').data('gists_id')

  $.each(gistsUrl, function(index, url) {
    $.getJSON(url + '.json?callback=?', function(response) {
      let link = $('<p>').append($('<link>').attr('rel', 'stylesheet').attr('href', response.stylesheet));
      $('[link-name-id="' + gistsId[index] + '"]').append(link).append(response.div);
    });
  });
});
