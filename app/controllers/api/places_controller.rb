class Api::PlacesController < ApplicationController
  before_action -> { set_decorator_context with_distance: true }, only: [:index]

  private
  def build_resource
    @place = Place.new resource_params
  end

  def collection
    @places = PlaceSearcher.search params.merge(user: { lat: current_user.lat, lng: current_user.lng })

    @places.each { |place| place.distance = current_user.distance_to place }
           .sort { |a, b| a.distance <=> b.distance }
  end

  def resource
    @place ||= Place.find params[:id]
  end

  def resource_params
    params.require(:place).permit(:name, :city, :place_id, :lat, :lng, tags: [])
  end
end