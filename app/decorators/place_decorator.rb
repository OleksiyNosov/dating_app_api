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
    m_to_km(object.distance).round(2) if object.respond_to? :distance
  end

  private
  def _only
    result = %i[id name place_id city overall_rating]

    return result if context[:short]

    result + %i[tags]
  end

  def _methods
    result = %i[coords]

    result += %i[ratings] if context[:place_user_ratings]

    result += %i[distance] if context[:with_distance]

    result
  end
end
