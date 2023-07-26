$(document).on('turbolinks:load', function(){
  let gistsUrl = $('.links').data('gists_url')
  let gistsId = $('.links').data('gists_id')

  let answerGistsUrl = $('.links').data('answer_gists_url')
  let answerGistsId = $('.links').data('answer_gists_id')

  $.each(gistsUrl.concat(answerGistsUrl), function(index, url) {
    $.getJSON(url + '.json?callback=?', function(response) {
      let link = $('<p>').append($('<link>').attr('rel', 'stylesheet').attr('href', response.stylesheet));
      $('[link-name-id="' + gistsId.concat(answerGistsId)[index] + '"]').append(link).append(response.div);
    });
  });
});
