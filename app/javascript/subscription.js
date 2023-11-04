document.addEventListener('DOMContentLoaded', function() {
  let dataSubscribedQuestions = document.querySelector('.right-question-buttons').getAttribute('data-subscribed-questions');
  let unsubscribeQuestionLink = document.querySelector('a.unsubscribe-question-link');
  let subscribeQuestionLink = document.querySelector('.subscribe-question-link');

  if (dataSubscribedQuestions == 'true') {
    unsubscribeQuestionLink.classList.remove('hidden');
  } else {
    subscribeQuestionLink.classList.remove('hidden');
  }

  subscribeQuestionLink.addEventListener('click', function(e) {
    buttonBrocessing(unsubscribeQuestionLink, e);
  });

  unsubscribeQuestionLink.addEventListener('click', function(e) {
    buttonBrocessing(subscribeQuestionLink, e);
  });
});

function buttonBrocessing(button, e) {
  e.target.classList.add('hidden');
  button.classList.remove('hidden');
}
