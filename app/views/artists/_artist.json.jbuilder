json.extract! artist, :id, :spotify_id, :name, :popularity, :created_at, :updated_at
json.url artist_url(artist, format: :json)
