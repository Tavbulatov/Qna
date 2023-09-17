import consumer from "./consumer"
import template from '../templates/answers.hbs';

let answersChannel

function createAndUpdateAnswersChannel() {
  let regexQuestionShowPathName = /^\/questions\/\d+$/;

  if(regexQuestionShowPathName.test(location.pathname)) {

    answersChannel = consumer.subscriptions.create({channel: "AnswersChannel", question_id: gon.question_id}, {
                      connected: function() {
                      },
                      received(data) {
                        let jsonData = JSON.parse(data)

                        document.querySelector('.answers_all').insertAdjacentHTML('beforeend', template(jsonData))

                        votes()

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
