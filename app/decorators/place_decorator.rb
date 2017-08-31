class PlaceDecorator < ApplicationDecorator
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

  private
  def _only
    %I[id name place_id tags city overall_rating]
  end

  def _methods
    result = %I[coords]

    result += %I[ratings] if context[:place_user_ratings]

    result
  end
end