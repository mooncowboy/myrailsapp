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
        artist.name = spotify_artist.name if spotify_artist
        artist.spotify_id = spotify_artist.id
        artist.popularity = spotify_artist.popularity
        artist.save!
      end

      redirect_to root_path
    end

    def fetch_user_playlists
      # Used in Review and Comment only
      token = session[:spotify_token]
      url = "https://api.spotify.com/v1/me/playlists"
      response = HTTParty.get(url, headers: { "Authorization" => "Bearer #{token}" })
      playlists = JSON.parse(response.body)["items"]
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
  