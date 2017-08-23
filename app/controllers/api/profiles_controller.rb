class Api::ProfilesController < ApplicationController
  skip_before_action :verify_authenticity_token, on: :create

  private
  def build_resource
    puts "resourse_params: #{ resource_params }"
    @user = User.new resource_params
  end

  def resource
    @user
  end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :gender,
                                 :birthday, :lat, :lng)
  end
end