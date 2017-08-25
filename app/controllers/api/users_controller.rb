class Api::UsersController < ApplicationController
  private
  def collection
    @users ||= User.all
  end

  def resource
    @user ||= User.find params[:id]
  end
end