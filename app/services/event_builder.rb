class EventBuilder
  def initialize resource_params, user, invites
    @resource_params = resource_params.merge user_id: user.id

    @invites = invites.uniq.map(&:to_i)
  end

  def build_event
    @event = Event.new @resource_params

    add_invites_to_event

    @event
  end

  private
  def add_invites_to_event
    @invites.each { |id| @event.invites.find_or_initialize_by user_id: id }
  end
end
