import consumer from "./consumer"
import template from '../templates/questions.hbs';

let questionsChannel

function createQuestionChannel() {
  if(!questionsChannel) {
    questionsChannel = consumer.subscriptions.create("QuestionsChannel", {
      connected: function() {
      },

      received: function(data) {
        let questions = document.querySelector('.questions')
        questions && document.querySelector('.questions').insertAdjacentHTML('beforeend', template(JSON.parse(data)))
      }
    });
  }
}

document.addEventListener('DOMContentLoaded', createQuestionChannel)
