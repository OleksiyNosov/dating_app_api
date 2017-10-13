class InviteDecorator < ApplicationDecorator
  ATTRS = %i[id respond]

  delegate_all

  decorates_association :user, context: { short: true }
  decorates_association :event, context: { short: true }

  private
  def _only
    ATTRS
  end

  def _methods
    return %i[user] if context[:with_user]

    return %i[event] if context[:with_event]
  end
end
