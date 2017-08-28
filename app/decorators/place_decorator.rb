class PlaceDecorator < ApplicationDecorator
  delegate_all

  def coords
    { lat: lat, lng: lng }
  end

  def ratings
    object.place_users.map do |pl_ur|
      { user: pl_ur.user.decorate(context: { short: true }), rating: pl_ur.rating }
    end
  end

  private
  def _only
    %I[id name place_id tags city overall_rating]
  end

  def _methods
    result = %I[coords]

    result += %I[ratings] if context[:user_ratings]

    result
  end
end