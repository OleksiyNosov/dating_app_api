class Api::AvatarsController < ApplicationController
  def create
    resource.update! resource_params

    head :ok
  end

  def destroy
    resource.avatar = nil

    resource.save!

    head :no_content
  end

  private
  def resource
    @user ||= current_user
  end

  def resource_params
    params.permit(:avatar)
  end
end
