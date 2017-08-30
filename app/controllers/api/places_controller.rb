class Api::PlacesController < ApplicationController
  private
  def build_resource
    @place = Place.new resource_params
  end

  def collection
    @places = PlaceSearcher.find_by city: params[:city], tags: params[:tags]
  end

  def resource
    @place ||= Place.find params[:id]
  end

  def resource_params
    params.require(:place).permit(:name, :city, :place_id, :lat, :lng, tags: [])
  end
end