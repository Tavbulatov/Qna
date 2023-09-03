import consumer from "./consumer"

document.addEventListener('turbolinks:load', function(){

  let answersAll = document.querySelector('.answers_all')

  consumer.subscriptions.create({channel: "AnswersChannel", question_id: gon.question_id}, {
      connected: function() {
        console.log(gon.question_id)
      },

      received(data) {
        console.log(data)
      }
    });

  // let subscribeToAnswer = function() {
  //   if(answersAll) {
  //     this.perform('follow')
  //   } else {
  //     this.perform('unfollow')
  //   }
  // }
  console.log('asd')
})
