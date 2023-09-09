import Handlebars from 'handlebars/runtime';

Handlebars.registerHelper('author_of?', function (author_id) {
  return author_id === gon.current_user_id
})
