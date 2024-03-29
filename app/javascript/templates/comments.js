window.commentsPartial = function commentsPartial(hbs) {
  return hbs.compile(
  `<div class="comment" id="{{id}}">
    <p>{{comment}}</p>
    {{#if (author_of? author_id)}}
      <p><a class="delete-comment" data-remote="true" rel="nofollow" data-method="delete" href="/comments/{{id}}">Delete comment</a></p>
    {{/if}}
  </div>`
  )
}
