class Api::PlacesController < ApplicationController
  private
  def build_resource
    @place = Place.new resource_params
  end

  def collection
    @places ||= Place.all
  end

  def resource
    @place ||= Place.find params[:id]
  end

  def resource_params
    params.require(:place).permit(:name, :city, { tags: [] }, :lat, :lng)
  end
end