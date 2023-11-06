import Handlebars from 'handlebars';

Handlebars.registerHelper('author_of?', function (author_id) {
  return author_id === gon.current_user_id
})

Handlebars.registerHelper('gist?', function (url) {
  if (url.includes('gist')) {
    return true;
  }
})
