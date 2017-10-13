class Api::EventsController < ApplicationController
  before_action :validate_author, only: %i[update destroy]
  before_action :add_new_invites, only: [:update]
  before_action -> { add_decorator_context(full: true) }, only: %i[show create update]
  before_action -> { add_decorator_context(short: true) }, only: [:index]

  private
  def collection
    @events = EventSearcher.search params.merge current_user: current_user
  end

  def resource
    @event ||= Event.find params[:id]
  end

  def build_resource
    @event = EventBuilder.new(resource_params, current_user, params[:event][:invites]).build_event
  end

  def resource_params
    params.require(:event).permit(:place_id, :title, :description, :kind, :start_time)
  end

  def validate_author
    return true if resource.user == current_user

    resource.errors.add :user, 'have no rights to update or delete that event'

    raise ActiveRecord::RecordInvalid
  end
end
