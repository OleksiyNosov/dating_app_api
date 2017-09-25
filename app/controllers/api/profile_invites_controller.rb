class Api::ProfileInvitesController < ApplicationController
  before_action -> { set_decorator_context(with_event: true) }, only: [:index, :show, :update]

  private
  def collection
    @invites = current_user.invites
  end

  def resource
    @invite = current_user.find params[:id]
  end

  def resource_params
    params.require(:invite).permit(:respond)
  end
end