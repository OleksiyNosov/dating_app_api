class Api::InvitesController < ApplicationController
  private
  def build_resource
    @invite = Invite.create resource_params.merge event: parent, respond: :no_respond 
  end

  def collection
    @invites = parent.invites
  end

  def resource
    @invite ||= Event.find params[:id]
  end

  def resource_params
    params.require(:invite).permit(:user_id)
  end

  def parent
    puts "params #{ params.to_s }"

    if params[:event_id] 
      @parent = Event.find params[:event_id]
    else 
      @parent = current_user
    end
  end
end