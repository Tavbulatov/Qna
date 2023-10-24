$(document).on('turbolinks:load', function() {
  let dataSubscribedQuestions = $('.right-question-buttons').data('subscribed-questions');
  let unsubscribeQuestionLink = $('.unsubscribe-question-link');
  let subscribeQuestionLink = $('.subscribe-question-link');

  if (dataSubscribedQuestions) {
    unsubscribeQuestionLink.removeClass('hidden');
  } else {
    subscribeQuestionLink.removeClass('hidden');
  }

  subscribeQuestionLink.on('click', function(e) {
    e.preventDefault();
    e.target.classList.add('hidden');
    unsubscribeQuestionLink.removeClass('hidden');
  });

  unsubscribeQuestionLink.on('click', function(e) {
    e.preventDefault();
    e.target.classList.add('hidden');
    subscribeQuestionLink.removeClass('hidden');
  });
});
