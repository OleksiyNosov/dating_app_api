class Api::UsersController < ApplicationController
  before_action -> { add_decorator_context short: true }, only: %i[insex show]

  private
  def collection
    @users ||= User.all
  end

  def resource
    @user ||= User.find params[:id]
  end
end
