import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "input" ]

  search2() {
    // Todo: could debounce
  }

  search() {
    const query = this.inputTarget.value;
    if (!query) return;

    fetch(`/spotify/search?query=${encodeURIComponent(query)}`)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        // Do something with the data (like update the DOM)
      })
      .catch(error => {
        console.error("Error searching Spotify:", error);
      });
  }
}
