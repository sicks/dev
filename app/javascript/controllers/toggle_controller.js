import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static values = {
    class: String,
    target: String
  }

  connect() {
    this.element.addEventListener('click', this.toggle.bind(this))
  }

  toggle(e) {
    if (this.hasTargetValue) {
      document.querySelector(this.targetValue).classList.toggle(this.classValue)
    } else {
      this.element.classList.toggle(this.classValue)
    }
  }
}
