class Api::AvatarsController < ApplicationController
  def create
    resource.update! resource_params

    head :ok
  end
  
  private
  def resource
    @user ||= current_user
  end

  def resource_params
    params.permit(:avatar)
  end
end