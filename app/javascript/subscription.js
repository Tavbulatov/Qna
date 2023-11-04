document.addEventListener('DOMContentLoaded', function() {
  let unsubscribeQuestionLink = document.querySelector('.unsubscribe-question-link');
  let subscribeQuestionLink = document.querySelector('.subscribe-question-link');

  if(subscribeQuestionLink) {
    subscribeQuestionLink.addEventListener('click', function(e) {
      buttonBrocessing(unsubscribeQuestionLink, e);
    })
  }

  if(unsubscribeQuestionLink) {
    unsubscribeQuestionLink.addEventListener('click', function(e) {
      buttonBrocessing(subscribeQuestionLink, e);
    })
  }
});

function buttonBrocessing(button, e) {
  e.target.classList.add('hidden');
  button.classList.remove('hidden');
}
