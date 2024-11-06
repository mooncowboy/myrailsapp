require 'rails_helper'

RSpec.describe ArtistsController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    let(:artist) { Artist.create(name: 'Test Artist') }

    it 'returns a successful response' do
      get :show, params: { id: artist.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new artist' do
      expect {
        post :create, params: { artist: { name: 'New Artist' } }
      }.to change(Artist, :count).by(1)
    end
  end

  describe 'PATCH #update' do
    let(:artist) { Artist.create(name: 'Old Name') }

    it 'updates the artist' do
      patch :update, params: { id: artist.id, artist: { name: 'New Name' } }
      artist.reload
      expect(artist.name).to eq('New Name')
    end
  end

  describe 'DELETE #destroy' do
    let!(:artist) { Artist.create(name: 'Artist to be deleted') }

    it 'deletes the artist' do
      expect {
        delete :destroy, params: { id: artist.id }
      }.to change(Artist, :count).by(-1)
    end
  end
end