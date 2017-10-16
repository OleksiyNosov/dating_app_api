class Api::UserRatingsController < ApplicationController
  private
  def collection
    parent
  end

  def parent
    @parent = if params[:user_id]
                User.find params[:user_id]
              else
                Place.find params[:place_id]
              end
  end
end
