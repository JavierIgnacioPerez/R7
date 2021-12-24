import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'chatMessages', 'newMessageArea']

  connect() {
    console.log('wea', this.chatMessagesTarget)
    let chatMessages = this.chatMessagesTarget
    chatMessages.scrollTo(0, chatMessages.scrollHeight)
    const config = { attributes: true, childList: true, subtree: true }
    const callback = function(mutationsList, observer) {
      for(const mutation of mutationsList) {
        chatMessages.scrollTo(0, chatMessages.scrollHeight)
        document.querySelector('#message_content').value = ''
      }
    }
    const observer = new MutationObserver(callback)
    observer.observe(chatMessages, config)
  }

  scrollBottom(el){
    el.scrollTo(0, el.scrollHeight)
  }
}
