class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

        def add_multiple
      spotify_ids = params[:spotify_ids]
      artists = spotify_ids.map do |spotify_id|
        spotify_artist = RSpotify::Artist.find(spotify_id)
        if spotify_artist
          {
            name: spotify_artist.name,
            spotify_id: spotify_artist.id,
            popularity: spotify_artist.popularity,
            created_at: Time.now,
            updated_at: Time.now
          }
        end
      end.compact
    
      Artist.insert_all(artists) if artists.any?
    
      redirect_to root_path
    end

  end
  