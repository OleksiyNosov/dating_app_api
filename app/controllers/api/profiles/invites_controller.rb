class Api::Profiles::InvitesController < Api::InvitesController
  before_action -> { add_decorator_context(with_event: true) }, only: %i[index show update]

  private
  def resource_params
    params.require(:invite).permit(:respond)
  end

  def parent
    @parent ||= current_user
  end
end
