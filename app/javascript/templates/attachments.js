
import Handlebars from 'handlebars';

Handlebars.registerPartial('attachments',
  `<div class="file" data-file-id="{{id}}">
    <a href={{url}}>{{name}}</a>

    {{#if (author_of? author_id)}}
        <p><a data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/attachments/{{id}}">Delete attach</a></p>
    {{/if}}
  </div>`
)
