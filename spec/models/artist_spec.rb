require 'rails_helper'

RSpec.describe Artist, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:genre) }
  it { should have_many(:albums) }
  
  describe '#custom_method' do
    it 'returns expected result' do
      artist = Artist.new(name: 'Test Artist', genre: 'Rock')
      expect(artist.custom_method).to eq('Expected Result')
    end
  end
end