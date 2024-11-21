import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "template" ]

  connect() {
    this.element[this.identifier] = this
  }

  insert(event) {
    const content = this.templateTarget.innerHTML
    event.currentTarget.insertAdjacentHTML('beforebegin', content)
    // The newly inserted element will be right before the current target
    const insertedElement = event.currentTarget.previousElementSibling
    if (insertedElement) insertedElement.focus()
  }
}