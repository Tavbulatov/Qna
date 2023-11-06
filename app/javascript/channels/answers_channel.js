import consumer from "./consumer"
import Handlebars from 'handlebars'
import '../helpers/handlebars'
let template = answersPartial(Handlebars)

let answersChannel

function createAndUpdateAnswersChannel() {
  let regexQuestionShowPathName = /^\/questions\/\d+$/;

  if(regexQuestionShowPathName.test(location.pathname)) {

    answersChannel = consumer.subscriptions.create({channel: "AnswersChannel", question_id: gon.question_id}, {
                      connected: function() {
                      },
                      received(data) {
                        let jsonData = JSON.parse(data)
                        if(gon.current_user_id != jsonData.author_id ){
                          document.querySelector('.answers_all').insertAdjacentHTML('beforeend', template(jsonData))
                        }
                        votes()
                        commentable()

                        jsonData.links.forEach(function(link){
                          if(link['url'].includes('gist')){
                            gistDownloadsAndPaste(link['url'], link['id'])
                          }
                        })
                      }
                    });
  }
  else {
    if(answersChannel) {
      answersChannel.unsubscribe()
    }
  }
}

document.addEventListener('turbolinks:load', createAndUpdateAnswersChannel)
