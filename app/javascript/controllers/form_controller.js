import { Controller } from '@hotwired/stimulus'
import autosize from 'src/autosize.esm'

export default class extends Controller {
  connect() {
    // resize textarea on content chagne
    this.element.querySelectorAll('textarea').forEach((el) => {
      autosize(el)
      el.addEventListener('input', this.handleTextAreaInput.bind(this))
    })
  }

  handleTextAreaInput(e) {
    autosize(e.target)
  }
}
