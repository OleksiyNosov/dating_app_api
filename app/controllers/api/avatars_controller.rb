class Api::AvatarsController < ApplicationController
  private
  def build_resource
    resource.update resource_params
  end
  
  def resource
    @user ||= current_user
  end

  def resource_params
    params.permit(:avatar)
  end
end