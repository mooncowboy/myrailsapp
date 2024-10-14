class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    # Adds multiple artists to the database using Spotify IDs.
    #
    # This action expects an array of Spotify IDs to be passed in the `params[:spotify_ids]`.
    # It retrieves the corresponding artists from Spotify using the RSpotify gem, creates new
    # Artist objects, and imports them into the database.
    #
    # Redirects to the root path after the operation is complete.
    #
    # @param [Array<String>] spotify_ids An array of Spotify IDs for the artists to be added.
    # @return [void]
    def add_multiple
      spotify_ids = params[:spotify_ids]
      spotify_artists = RSpotify::Artist.find(spotify_ids)
    
      artists = spotify_artists.map do |spotify_artist|
        next unless spotify_artist
    
        Artist.new(
          name: spotify_artist.name,
          spotify_id: spotify_artist.id,
          popularity: spotify_artist.popularity
        )
      end.compact
    
      Artist.import(artists)
    
      redirect_to root_path
    end

  end
  