class Api::UserRatingsController < ApplicationController
  private
  def collection
    parent
  end

  def parent
    if params[:user_id] 
      @parent = User.find params[:user_id]
    else 
      @parent = Place.find params[:place_id]
    end
  end
end