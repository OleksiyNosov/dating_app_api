class InviteDecorator < ApplicationDecorator
  delegate_all

  decorates_association :user, context: { short: true }
  decorates_association :event

  private
  def _only
    %I[id respond]
  end

  def _methods
    return %I[user] if context[:with_user]

    return %I[event] if context[:with_event]
  end
end