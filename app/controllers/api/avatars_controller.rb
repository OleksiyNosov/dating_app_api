class Api::AvatarsController < ApplicationController
  private
  def resource
    @user ||= current_user
  end

  def resource_params
    params.permit(:avatar)
  end
end