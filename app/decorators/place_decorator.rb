class PlaceDecorator < ApplicationDecorator
  include SimpleMathOperations

  delegate_all

  decorates_association :place_users

  def coords
    { lat: lat, lng: lng }
  end

  def ratings
    place_users.map do |place_user|
      { user: place_user.user.decorate(context: { short: true }), rating: place_user.rating }
    end
  end

  def distance
    miles_to_km(object.distance).round(2)
  end

  private
  def _only
    result = %I[id name place_id city overall_rating]

    return result if context[:short]

    result += %I[tags] 
  end

  def _methods
    result = %I[coords]

    result += %I[ratings] if context[:place_user_ratings]

    result += %I[distance] if context[:with_distance]

    result
  end
end