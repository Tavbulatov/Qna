import Handlebars from 'handlebars';

Handlebars.registerPartial('links',
  `<div link-id={{id}}>
    {{#if (gist? url)}}
      <p link-name-id={{id}}>{{name}}<p>
    {{else}}
      <p><a target="_blank" href={{url}}>{{name}}</a></p>
    {{/if}}

    {{#if (author_of? author_id)}}
      <p><a data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/links/{{id}}">Delete link</a></p>
    {{/if}}
  </div>`
)
