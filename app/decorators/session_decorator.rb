class SessionDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    user.decorate(context: { create: true })
  end
end