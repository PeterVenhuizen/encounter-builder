import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "results", "searchform" ]
  timeout
  pendingRequest

  connect() {
    // console.log("Connected!")
  }

  loading() {
    this.pendingRequest = true
    setTimeout(() => {
      if(this.pendingRequest) {
        this.resultsTarget.innerHTML = "<div>Searching...</div>"
      }
    }, 500)
  }

  search() {
    clearTimeout(this.timeout)
    let q = this.searchformTarget.querySelector('#search');
    this.timeout = setTimeout(() => {
      Rails.fire(this.searchformTarget, 'submit')
    }, 200)
  }

  handleResults() {
    this.pendingRequest = false
    const [data, status, xhr] = event.detail
    this.resultsTarget.innerHTML = xhr.response
  }
}