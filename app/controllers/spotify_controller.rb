class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    # Adds multiple artists to the database based on Spotify IDs provided in the parameters.
    #
    # This method retrieves artist information from the Spotify API for each Spotify ID
    # in the `spotify_ids` parameter, constructs a list of artist attributes, and inserts
    # them into the `Artist` model in a single database operation.
    #
    # Parameters:
    # - spotify_ids: An array of Spotify artist IDs.
    #
    # Redirects to the root path after the operation is complete.
    def add_multiple
      spotify_ids = params[:spotify_ids]
      artists = []
    
      spotify_ids.each do |spotify_id|
        spotify_artist = RSpotify::Artist.find(spotify_id)
        if spotify_artist
          artists << {
            name: spotify_artist.name,
            spotify_id: spotify_artist.id,
            popularity: spotify_artist.popularity,
            created_at: Time.now,
            updated_at: Time.now
          }
        end
      end
    
      Artist.insert_all(artists) if artists.any?
    
      redirect_to root_path
    end

  end
  