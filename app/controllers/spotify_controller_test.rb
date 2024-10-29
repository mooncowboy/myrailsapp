require 'test_helper'

class SpotifyControllerTest < ActionDispatch::IntegrationTest
    test "should add multiple artists" do
        spotify_ids = ['1vCWHaC5f2uS3yhpwWbIA6', '3TVXtAsR1Inumwj472S9r4']
        artists_data = [
            {
                name: 'Avicii',
                spotify_id: '1vCWHaC5f2uS3yhpwWbIA6',
                popularity: 85,
                created_at: Time.now,
                updated_at: Time.now
            },
            {
                name: 'Drake',
                spotify_id: '3TVXtAsR1Inumwj472S9r4',
                popularity: 90,
                created_at: Time.now,
                updated_at: Time.now
            }
        ]

        RSpotify::Artist.stub :find, ->(id) { artists_data.find { |artist| artist[:spotify_id] == id } } do
            assert_difference 'Artist.count', 2 do
                post add_multiple_spotify_url, params: { spotify_ids: spotify_ids }
            end
        end

        assert_redirected_to root_path
    end
end