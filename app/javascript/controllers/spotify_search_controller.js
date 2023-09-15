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
        // This returns a list of artists from Spotify. Show the first one in an alert.
        // if (data.artists.length > 0) {
        //   alert(data.artists[0].name);
        // }

    // Get the artists from the data object
    const artists = data.artists;

    // Create a list element
    const artistList = document.createElement('ul');

    // Loop through the artists
    artists.forEach(artist => {
      // Create a list item
      const artistItem = document.createElement('li');
      // Add the artist name and ID to the list item
      artistItem.textContent = `${artist.name} (Spotify ID: ${artist.id})`;
      // Add the list item to the list
      artistList.appendChild(artistItem);
    });

    // Add the list to the page
    document.body.appendChild(artistList);

      })
      .catch(error => {
        console.error("Error searching Spotify:", error);
      });
  }
}
