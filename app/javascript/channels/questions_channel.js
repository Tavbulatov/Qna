import consumer from "./consumer"

document.addEventListener('turbolinks:load', function(){
  // let questions = document.querySelector('.questions');

  consumer.subscriptions.create("QuestionsChannel", {
    connected: function() {
    },

    received: function(data) {
      console.log(data)
    }
  });
})
