class Api::EventsController < ApplicationController
  before_action :validate_author, only: [:update, :delete]
  before_action :add_new_invites, only: [:update]
  before_action -> { set_decorator_context(full: true) }, only: [:show, :create, :update]
  before_action -> { set_decorator_context(short: true) }, only: [:index]

  private
  def collection
    @events = EventSearcher.search params.merge current_user: current_user
  end

  def resource
    @event ||= Event.find params[:id]
  end

  def build_resource
    @event = Event.new resource_params.merge user_id: current_user.id

    add_new_invites
  end

  def resource_params
    params.require(:event).permit(:place_id, :title, :description, :kind, :start_time)
  end

  def validate_author
    head :forbidden if resource.user != current_user   
  end

  def add_new_invites
    params[:event][:invites].uniq.map(&:to_i).each { |id| resource.new_invite_if_not_exist User.find id }
  end
end