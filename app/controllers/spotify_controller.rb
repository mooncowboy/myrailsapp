class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    def add_multiple
      spotify_ids = params[:spotify_ids]
      spotify_ids.each do |spotify_id|
        spotify_artist = RSpotify::Artist.find(spotify_id)
        artist = Artist.new
        artist.name = spotify_artist.name
        artist.spotify_id = spotify_artist.id
        artist.popularity = spotify_artist.popularity
        artist.save!
      end

      redirect_to root_path
    end

  end
  