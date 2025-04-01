class SpotifyController < ApplicationController
    def search
      query = params[:query]
  
      @results = RSpotify::Artist.search(query)

      #render json: { artists: results }
    end

    # Adds multiple artists to the database using their Spotify IDs.
    #
    # This method retrieves a list of Spotify artist IDs from the request parameters,
    # fetches the corresponding artist data from the Spotify API using the RSpotify gem,
    # and creates new Artist records in the database with the retrieved data.
    #
    # Parameters:
    # - spotify_ids: An array of Spotify artist IDs passed in the request parameters.
    #
    # Behavior:
    # - For each Spotify ID in the array, the method fetches the artist data from Spotify.
    # - Creates a new Artist record with the name, Spotify ID, and popularity of the artist.
    # - Saves the Artist record to the database.
    #
    # Redirects:
    # - After processing all Spotify IDs, the method redirects the user to the root path.
    #
    # Exceptions:
    # - Raises an exception if saving an Artist record fails (due to `save!`).
    def add_multiple
      spotify_ids = params[:spotify_ids]
      spotify_ids.each do |spotify_id|
        spotify_artist = RSpotify::Artist.find(spotify_id)
        artist = Artist.new
        artist.name = spotify_artist.name if spotify_artist
        artist.spotify_id = spotify_artist.id
        artist.popularity = spotify_artist.popularity
        artist.save!
      end

      redirect_to root_path
    end

    def fetch_user_playlists
      if spotify_token = nil
        return
      # Used in Review and Comment only
      token = session[:spotify_token]
      if token.nil? || token.empty?
        flash[:alert] = "Spotify token is missing or invalid"
        redirect_to root_path and return
      end
      url = "https://api.spotify.com/v1/me/playlists"
      begin
        response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{token}" })
        if response.code != 200
          flash[:alert] = "Failed to fetch playlists: #{response.message}"
          return render json: { error: "Failed to fetch playlists" }, status: :bad_request
        end
      rescue StandardError => e
        flash[:alert] = "An error occurred: #{e.message}"
        return render json: { error: "An error occurred while fetching playlists" }, status: :internal_server_error
      end
      if response.success?
        body = JSON.parse(response.body) rescue {}
        playlists = body["items"] || []
      else
        playlists = []
      end
      result = []
    
      for p in playlists do
        playlist_name = p["name"]
        track_count = p["tracks"]["total"]
        result << { title: playlist_name, count: track_count }
      end
    
      if result.length > 0
        flash[:notice] = "Found #{result.length} playlists"
      else
        flash[:alert] = "You have no playlists"
      end
    
      render json: result
    end

    # def fetch_top_tracks
    #   # Used in Review and Comment only
    #   token = session[:spotify_token]
    #   url = "https://api.spotify.com/v1/me/top/tracks"
    #   headers = { "Authorization" => "Bearer #{token}" }
    
    #   response = HTTParty.get(url, headers: headers)
    
    #   if response.success?
    #     data = JSON.parse(response.body)
    #     top_tracks = data["items"].map do |track|
    #       {
    #         name: track["name"],
    #         artist: track["artists"].first["name"],
    #         album: track["album"]["name"],
    #         popularity: track["popularity"]
    #       }
    #     end
    
    #     render json: top_tracks
    #   else
    #     render json: { error: "Unable to fetch top tracks" }, status: :bad_request
    #   end
    # end
    
  end
  