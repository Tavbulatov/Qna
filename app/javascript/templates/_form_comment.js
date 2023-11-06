import Handlebars from 'handlebars';

Handlebars.registerPartial('_form_comment',
  `<form class="new-comment" action="/answers/{{model_id}}/comments" accept-charset="UTF-8" data-remote="true" method="post"><input type="hidden" name="authenticity_token" value={{authenticity_token}} autocomplete="off">
    <p><label for="comment_comment">Comment</label>
    <br>
    <textarea name="comment[comment]" id="comment_body" cols="70" rows="5"></textarea>
    <br>
    <input type="submit" name="commit" value="Create Comment" data-disable-with="Create Comment"></p>
  </form>`
)
