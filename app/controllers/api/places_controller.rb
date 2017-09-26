class Api::PlacesController < ApplicationController
  before_action -> { set_decorator_context with_distance: true }, only: :index

  private
  def build_resource
    @place = Place.new resource_params
  end

  def collection
    @places = PlaceSearcher.search params.merge current_user: current_user
  end

  def resource
    @place ||= Place.find params[:id]
  end

  def resource_params
    params.require(:place).permit(:name, :city, :place_id, :lat, :lng, tags: [])
  end
end