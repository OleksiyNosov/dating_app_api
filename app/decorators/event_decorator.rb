class EventDecorator < ApplicationDecorator
  ATTRS = %i[id kind title description]

  delegate_all

  decorates_association :place, context: { short: true }
  decorates_association :user, context: { short: true }

  def date
    start_time.strftime "%F"
  end

  def time
    start_time.strftime "%H:%M"
  end

  def author
    user
  end

  def people_attended_count
    object.invites.attend.count
  end

  def people_attended
    object.invites.attend.map { |invite| invite.user.decorate(context: { short: true }) }
  end

  def invites
    object.invites.decorate(context: { with_user: true })
  end

  private
  def _only
    ATTRS
  end

  def _methods
    return %i[place date time author people_attended_count people_attended invites] if context[:full]

    return %i[place date time] if context[:short]
  end
end