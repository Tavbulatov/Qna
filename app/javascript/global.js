window.gistDownloadsAndPaste = function gistDownloadsAndPaste(url, index) {
  $.getJSON(url + '.json?callback=?', function(response) {
    let link = $('<p>').append($('<link>').attr('rel', 'stylesheet').attr('href', response.stylesheet));
    $('[link-name-id="' + index + '"]').append(link).append(response.div);
  })
}
