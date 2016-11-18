module ReviewsHelper
  def star_rating(rating)
    return rating.round unless rating.is_a?(Fixnum)
    remainder = (5 - rating.round)
    "★" * rating + "☆" * remainder
  end
end
