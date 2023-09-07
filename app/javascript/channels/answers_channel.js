import consumer from "./consumer"

document.addEventListener('turbolinks:load', function(){

  consumer.subscriptions.create({channel: "AnswersChannel", question_id: gon.question_id}, {
    connected: function() {
      console.log(gon.question_id)
    },

    received(data) {
      console.log(data)
    }
  });
})
