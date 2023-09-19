import template  from "templates/comments.hbs"
let event = new Event('reloadButtons')

window.commentable = function commentable(){

  let newCommentForms = document.querySelectorAll('.new-comment')

  newCommentForms.forEach(function(form){
    form.addEventListener('ajax:success', (e)=>{
      document.querySelector('.flash_message').textContent = e.detail[0][1]
      e.target[1].value=''

      let jsonData = e.detail[0][0]

      if(jsonData.comment) {
        let typeResource = jsonData.commentable_type == 'Answer'? 'answer': 'question'
        console.log(jsonData)
        document.querySelector(`.comments[data-${typeResource}-id="${jsonData.commentable_id}"]`).insertAdjacentHTML('beforeend', template(jsonData))
        document.dispatchEvent(event)
      }
    })
  })
}

function buttonsAnswerDelete(){
  let deleteButtons = document.querySelectorAll('.delete-comment')

  deleteButtons.forEach(elem =>{
    elem.addEventListener('ajax:success', (e)=>{
      document.querySelector('.flash_message').textContent = e.detail[0][0]
      e.target.parentNode.parentNode.remove()
    })
  })
}

document.addEventListener('turbolinks:load', commentable)
document.addEventListener('turbolinks:load', buttonsAnswerDelete)
document.addEventListener('reloadButtons', buttonsAnswerDelete)
