class Api::EventInvitesController < ApplicationController
  before_action -> { set_decorator_context(with_user: true) }, only: [:index, :show, :create]

  private
  def build_resource
    @invite = Event.invites.build resource_params
  end

  def collection
    @invites ||= parent.invites
  end

  def resource
    @invite ||= parent.find params[:id]
  end

  def resource_params
    params.require(:invite).permit(:user_id)
  end

  def parent
    @parent ||= Event.find params[:event_id]
  end
end