class EventDecorator < ApplicationDecorator
  delegate_all

  decorates_association :place
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
    -1
  end

  def people_attended
    ["not implemented yet"]
  end

  def invites
    ["not implemented yet"]
  end

  private
  def _only
    %I[id kind title description]
  end

  def _methods
    %I[place date time author people_attended_count people_attended invites]
  end
end