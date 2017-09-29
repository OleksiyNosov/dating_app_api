class Api::Events::InvitesController < Api::InvitesController 
  before_action -> { set_decorator_context(with_user: true) }, only: [:index, :show, :create]

  private
  def build_resource
    @invite = parent.invites.build resource_params
  end

  def resource_params
    params.require(:invite).permit(:user_id)
  end

  def parent
    @parent ||= Event.find params[:event_id]
  end
end