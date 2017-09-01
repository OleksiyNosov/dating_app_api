class Api::PlaceUsersController < ApplicationController
  private
  def build_resource
    @place_user = parent.place_users.build resource_params.merge(user: current_user)
  end

  def resource
    @place_user ||= parent.place_users.find_by user: current_user 
  end

  def resource_params
    params.require(:place_user).permit(:rating, :review)
  end

  def parent
    @parent ||= Place.find params[:place_id]
  end
end