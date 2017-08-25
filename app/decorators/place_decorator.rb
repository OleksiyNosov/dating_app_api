class PlaceDecorator < ApplicationDecorator
  delegate_all

  def coords
    { lat: lat, lng: lng }
  end

  private
  def _only
    %I[id name place_id tags city overall_rating]
  end

  def _methods
    %I[coords]
  end
end