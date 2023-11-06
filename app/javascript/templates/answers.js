window.answersPartial = function answersPartial(hbs) {
  return hbs.compile(
    `<br>
    <div answer-id={{id}} class="answer_error"></div>

    <div answer-id={{id}} class="answer">
      <li>{{body}}</li>

      {{#unless (author_of? author_id)}}
        {{>votes model_id=id token=authenticity_token}}
      {{/unless}}


      <h4>Rating answer</h4>
      <p id="Answer-{{id}}">{{rating}}</p>

      {{#if files}}
        {{#each files}}
          {{>attachments url=this.url name=this.name id=this.id author_id=author_id}}
        {{/each}}
      {{/if}}


      {{#if links}}
        <h2>Links</h2>
        {{#each links}}
          {{>links url=this.url name=this.name id=this.id author_id=this.author_id}}
        {{/each}}
      {{/if}}


      <div class="comments" data-answer-id={{id}}>
        <h2>Comments</h2>
      </div>
      {{>_form_comment model_id=id authenticity_token=authenticity_token}}


      <hr>
      {{#if (author_of? author_id)}}
        <a data-remote="true" rel="nofollow" data-method="patch" href="/answers/{{id}}/best">Best</a>
        | |
        <a data-confirm="Are you sure?" data-remote="true" rel="nofollow" data-method="delete" href="/answers/{{id}}">Delete</a>
        | |
        <a class="edit-answer-link" data-answer-id={{id}} href="#">Edit answer</a>
      {{/if}}
    </div>


    <form id="edit-answer-{{id}}" class="hidden" enctype="multipart/form-data" action="/answers/{{id}}" accept-charset="UTF-8" data-remote="true" method="post">
      <input type="hidden" name="_method" value="patch" autocomplete="off">
      <input type="hidden" name="authenticity_token" value={{authenticity_token}} autocomplete="off">

      <p>
        <label for="answer_body">Body</label>
        <br>
        <textarea name="answer[body]" id="answer_body" cols="70" rows="10">{{body}}</textarea>
      </p>

      <p>
        <label for="answer_files">Files</label>
        <br>
        <input multiple="multiple" type="file" name="answer[files][]" id="answer_files">
      </p>

      <p>
        <a class="add_fields" data-association="link" data-associations="links" data-association-insertion-template="<div class=&quot;link_fields&quot;><h2>Link</h2><p><label for=&quot;answer_links_attributes_new_links_name&quot;>Name</label><br /><input type=&quot;text&quot; name=&quot;answer[links_attributes][new_links][name]&quot; id=&quot;answer_links_attributes_new_links_name&quot; /></p><p><label for=&quot;answer_links_attributes_new_links_url&quot;>Url</label><br /><input type=&quot;url&quot; name=&quot;answer[links_attributes][new_links][url]&quot; id=&quot;answer_links_attributes_new_links_url&quot; /></p></div>" href="#">Add link
        </a>
      </p>

      <p>
        <input type="submit" name="commit" value="Update Answer" class="save-answer" data-answer-id={{id}} data-disable-with="Update Answer">
      </p>
    </form>`
  )
}
