module ApplicationHelper
    def popularity_to_stars(num)
        (num / 20.0).ceil
      end
end
