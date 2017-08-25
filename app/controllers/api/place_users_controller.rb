class Api::PlaceUsersController < ApplicationController
  private
  def build_resource
    @place_user = parent.place_users.build resource_params.merge(user_id: current_user.id)
  end

  def resource
    @place_user ||= parent.place_users.find { |p| p[:user_id] == current_user.id }
  end

  def resource_params
    params.require(:place_user).permit(:rating)
  end

  def parent
    @parent ||= Place.find params[:place_id]
  end
end