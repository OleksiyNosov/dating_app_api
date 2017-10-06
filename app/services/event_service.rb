class EventService 
  attr_reader :resource_params, :invites, :event

  def initialize resource_params, user, invites
    @resource_params = resource_params.merge user_id: user.id

    @invites = invites.uniq.map(&:to_i)
  end

  def build_event
    @event = Event.new resource_params
  
    add_invites_to_event
  
    event
  end

  def add_invites_to_event
    invites.each { |id| event.new_invite_if_not_exist User.find id }
  end
end