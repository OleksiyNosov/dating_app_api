class Api::PlacesController < ApplicationController
  before_action -> { add_decorator_context with_distance: true }, only: :index

  private
  def build_resource
    @place = Place.new resource_params
  end

  def collection
    @places = PlaceSearcher.search params.merge current_user: current_user
  end

  def resource
    return @place if @place

    return @place = Place.find(params[:id]) unless params[:id].to_i.zero?

    @place = Place.find_by(city: params[:id])

    @place ||= PlaceApiGenerator.new(params[:id]).download_and_create_place
  end

  def resource_params
    params.require(:place).permit(:name, :city, :place_id, :lat, :lng, tags: [])
  end
end
