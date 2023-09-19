import consumer from "./consumer"
import template from '../templates/comments.hbs';

// let questionsChannel

function createCommentsChannel() {
  // if(!questionsChannel) {
     consumer.subscriptions.create("CommentsChannel", {
      connected: function() {
      },

      received: function(data) {
        let jsonData = JSON.parse(data)
        let typeResource = jsonData.commentable_type == 'Answer'? 'answer': 'question'

        if(gon.current_user_id != jsonData.author_id ){
          document.querySelector(`.comments[data-${typeResource}-id="${jsonData.commentable_id}"]`).insertAdjacentHTML('beforeend', template(jsonData))
        }
      }
    });
  // }
}

document.addEventListener('DOMContentLoaded', createCommentsChannel)
