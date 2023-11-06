window.questionsPartial = function questionsPartial(hbs) {
  return hbs.compile(
    `<h2><a href="/questions/{{id}}">{{title}}</a></h2>
    <p>{{body}}</p>

    {{#if (author_of? author_id)}}
      <a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/questions/{{id}}">Delete</a>
    {{/if}}`
  )
}
