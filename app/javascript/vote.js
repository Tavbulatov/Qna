window.votes = function votes() {
  //загружаем все формы на странице
  let forms = document.querySelectorAll('.vote-form');

  //загружаем все кнопки на странице для отмены голоса
  let buttonsCancel = document.querySelectorAll('a.vote-button')

  // метод принимает массив кнопок и вешает на каждую кнопку обработчик
  function AddingHandlerToEachButton(buttons) {
    buttons.forEach(function(button){
      // вешаем на каждую кнопку обработчик
      button.addEventListener('click', function(e) {

      //кнопка на которую кликнули
      let pressedButton = e.target

      let dataPressedButton = pressedButton.getAttribute('data') // у кнопки и у формы идентичные дата

      // удаляем кнопку на которую кликнули
      pressedButton.remove()

      // вскрываем форму находя с помощью дата аттр кнопки.
      document.querySelector(`[data-vote-form-id=${dataPressedButton}]`).classList.remove('hidden')

      // берем из json обновленный рейтинг и втставляем
      pressedButton.addEventListener('ajax:success', function(e){
        document.querySelector(`p[id=${dataPressedButton}]`).textContent = e.detail[0][0]

        // добавляю сообщение
        addMessage(dataPressedButton, e.detail[0][1])
      })
    })
   })
  }

  //метод для добавления сообщения
  function addMessage(dataAttr,message) {
    document.querySelector(`div[data=${dataAttr}`).textContent = message
  }

  AddingHandlerToEachButton(buttonsCancel)

  // проходим по всем формам берем все кнопки каждой формы
  forms.forEach(function(form) {
    form.addEventListener('ajax:success', function(e){
      let formEvent = e.target
      let formEventData = formEvent.dataset.voteFormId
      // скрываем форму
      formEvent.classList.add('hidden')

      //cоздаем новую кнопку на замену формы
      let newCancelButton = document.createElement('a');
      newCancelButton.classList.add('vote-button');
      newCancelButton.setAttribute('data', formEventData);
      newCancelButton.setAttribute('data-remote', 'true');
      newCancelButton.setAttribute('rel', 'nofollow');
      newCancelButton.setAttribute('data-method', 'delete');
      newCancelButton.textContent = 'Cancel vote';

      // берем из json обновленный рейтинг и втставляем
      document.querySelector(`p[id=${formEventData}]`).textContent = e.detail[0][0]

      // добавляю сообщение
      addMessage(formEventData, e.detail[0][1])

      // определяем правильный путь для кнопки на созданный голос, берем из json айди голоса
      newCancelButton.setAttribute('href', `/votes/${e.detail[0][2]}`);

      // добавляю новую кнопку после формы которую скрыли выше
      formEvent.insertAdjacentElement('afterend', newCancelButton);

      // повторно вызываю метод чтобы повесить обработчик на новую кнопку
      AddingHandlerToEachButton(document.querySelectorAll('a.vote-button'))
    });
  });
}
// document.addEventListener('turbolinks:load', function() {})
document.addEventListener('turbolinks:load', votes)
