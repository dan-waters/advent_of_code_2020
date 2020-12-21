class Adapter
  def initialize(rating)
    @rating = rating.to_i
  end

  def can_be_attached?(previous_adapter)
    rating.between?(previous_adapter.rating + 1, previous_adapter.rating + 3)
  end

  def rating
    @rating
  end

  def to_s
    "#<Adapter: rating #{rating}>"
  end
end