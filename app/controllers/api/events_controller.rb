class Api::EventsController < ApplicationController
  before_action :validate_author, only: [:update, :delete]
  before_action -> { set_decorator_context(full: true) }, only: [:show, :create, :update]
  before_action -> { set_decorator_context(short: true) }, only: [:index]

  private
  def collection
    @events ||= Event.all
  end

  def resource
    @event ||= Event.find params[:id]
  end

  def build_resource
    @event = Event.new resource_params.merge user_id: current_user.id

    params[:event][:invites].each { |id| @event.create_invite_if_not_exist User.find(id.to_i) }
  end

  def resource_params
    params.require(:event).permit(:place_id, :title, :description, :kind, :start_time, :invites)
  end

  def validate_author
    head :forbidden if resource.user != current_user   
  end
end