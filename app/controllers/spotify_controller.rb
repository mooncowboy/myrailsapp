class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      results = RSpotify::Artist.search(query)
      # Simplifying the results to just names for this example.
      artist_names = results.map(&:name)
  
      render json: { artists: artist_names }
    end
  end
  