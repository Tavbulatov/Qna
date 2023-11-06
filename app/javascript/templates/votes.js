import Handlebars from 'handlebars';

Handlebars.registerPartial('votes',
  `<div class="vote-message" data="Answer-{{model_id}}"></div>

  <form class="vote-form " data-vote-form-id="Answer-{{model_id}}" action="/answers/{{model_id}}/votes" accept-charset="UTF-8" data-remote="true" method="post">

    <input type="hidden" name="authenticity_token" value={{token}} autocomplete="off">

    <p>
      <button name="vote[body]" type="submit" value="up">Up</button>
      |
      <button name="vote[body]" type="submit" value="down">Down</button>
    </p>
  </form>`
)
