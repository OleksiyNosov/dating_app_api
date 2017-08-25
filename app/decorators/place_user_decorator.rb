class PlaceUserDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    place.decorate 
  end
end