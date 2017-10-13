class Api::ProfilesController < ApplicationController
  before_action -> { add_decorator_context full: true }, only: :show

  skip_before_action :authenticate, only: :create

  private
  def build_resource
    @user = User.new resource_params
  end

  def resource
    @user ||= current_user
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender,
                                 :birthday, :lat, :lng)
  end
end
