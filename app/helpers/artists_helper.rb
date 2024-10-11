module ArtistsHelper
  def star_rating(score)
    stars = (score / 20.0).round
    '★' * stars + '☆' * (5 - stars)
  end
end