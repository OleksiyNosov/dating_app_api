class UserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :places
  decorates_association :place_users

  def full_name
    "#{ first_name } #{ last_name }"  
  end

  def age
    years  = Time.zone.now.year - birthday.year
    y_days = Time.zone.now.yday - birthday.yday
    
    y_days < 0 ? years - 1 : years
  end

  def coords
    { lat: lat, lng: lng }
  end

  def avatar
    { original_url: object.avatar.url, thumb_url: object.avatar.url(:thumb) }
  end

  def collection
    PlaceUserDecorator.decorate_collection place_users, context: { user_user_ratings: true }
  end

  private
  def _only
    return [] if context[:user_user_ratings]

    result = %i[id gender]

    result += %i[email birthday] if context[:full]

    result
  end

  def _methods
    return %i[collection] if context[:user_user_ratings]

    result = %i[full_name avatar]

    result += %i[coords] if context[:full]

    result += %i[age] if context[:short]

    result
  end
end