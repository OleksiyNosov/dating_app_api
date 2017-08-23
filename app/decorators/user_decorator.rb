class UserDecorator < ApplicationDecorator
  delegate_all

  def full_name
    "#{ first_name } #{ last_name }"  
  end

  def coords
    { lat: lat, lng: lng }
  end

  private
  def _only
    %I[id email gender birthday]
  end

  def _methods
    %I[full_name coords]
  end
end