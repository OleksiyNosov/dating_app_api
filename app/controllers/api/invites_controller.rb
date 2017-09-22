class Api::InvitesController < ApplicationController
  before_action -> { set_proper_decorator_context }, only: [:index, :show]
  before_action -> { set_decorator_context(with_user: true) }, only: [:create]
  before_action -> { set_decorator_context(with_event: true) }, only: [:update]

  private
  def build_resource
    @invite = Invite.create! resource_params.merge event: parent, respond: :no_respond
  end

  def collection
    @invites = parent.invites
  end

  def resource
    @invite ||= Invite.find params[:id]
  end

  def profile_is_parent?
    !params[:event_id]
  end

  def resource_params
    if profile_is_parent?
      params.require(:invite).permit(:respond)
    else
      params.require(:invite).permit(:user_id)
    end
  end

  def parent
    if profile_is_parent?
      @parent = current_user
    else 
      @parent = Event.find params[:event_id]
    end
  end

  def set_proper_decorator_context
    if profile_is_parent?
      set_decorator_context with_event: true
    else
      set_decorator_context with_user: true
    end
  end
end