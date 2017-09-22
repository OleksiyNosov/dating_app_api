class Api::EventsController < ApplicationController
  before_action :validate_author, only: [:update, :delete]

  private
  def collection
    @events ||= Event.all
  end

  def resource
    @event ||= Event.find params[:id]
  end

  def build_resource
    @event = Event.create resource_params.merge user_id: current_user.id

    params[:event][:invites].each { |id| @event.create_invite_if_not_exist User.find(id.to_i) }
  end

  def resource_params
    params.require(:event).permit(:place_id, :title, :description, :kind, :start_time, :invites)
  end

  def validate_author
    head :forbidden if resource.user != current_user   
  end
end