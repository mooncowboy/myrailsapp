class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    # Adds multiple artists to the database using their Spotify IDs.
    #
    # This action expects an array of Spotify IDs to be passed in the `params[:spotify_ids]`.
    # It retrieves the corresponding artist information from the Spotify API using the RSpotify gem,
    # creates new Artist objects, and imports them into the database.
    #
    # Redirects to the root path after the operation is complete.
    #
    # @example
    #   POST /spotify/add_multiple
    #   params: { spotify_ids: ['1Xyo4u8uXC1ZmMpatF05PJ', '3TVXtAsR1Inumwj472S9r4'] }
    #
    # @note This method assumes that the `activerecord-import` gem is installed and configured.
    def add_multiple
      spotify_ids = params[:spotify_ids]
      spotify_artists = RSpotify::Artist.find(spotify_ids)
    
      artists = spotify_artists.map do |spotify_artist|
        Artist.new(
          name: spotify_artist.name,
          spotify_id: spotify_artist.id,
          popularity: spotify_artist.popularity
        )
      end
    
      Artist.import(artists) # Assuming you have the activerecord-import gem installed
    
      redirect_to root_path
    end

  end
  