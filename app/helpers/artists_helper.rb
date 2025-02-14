module ArtistsHelper
  def star_rating(popularity)
    stars = (popularity / 20.0).ceil
    full_stars = '★' * stars
    empty_stars = '☆' * (5 - stars)
    full_stars + empty_stars
  end
end
