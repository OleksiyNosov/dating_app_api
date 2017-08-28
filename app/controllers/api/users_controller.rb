class Api::UsersController < ApplicationController
  private
  def collection
    @users ||= User.all
  end

  def resource
    @user ||= User.find params[:id]
  end

  def set_decorator_context
    @decorator_context = { context: { short: true } }
  end
end