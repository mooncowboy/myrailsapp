class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    # Adds multiple artists to the database based on Spotify IDs provided in the parameters.
    #
    # This method expects an array of Spotify IDs to be passed in the `spotify_ids` parameter.
    # It fetches the artist information from the Spotify API for each ID, constructs a hash
    # with the artist's name, Spotify ID, popularity, and timestamps, and inserts all the
    # artist records into the database.
    #
    # If no valid artists are found, no records are inserted.
    #
    # After processing, the method redirects to the root path.
    #
    # @example
    #   POST /spotify/add_multiple
    #   Params: { spotify_ids: ['1vCWHaC5f2uS3yhpwWbIA6', '3TVXtAsR1Inumwj472S9r4'] }
    #
    # @return [void]
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