class SessionDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    { user: user.decorate, auth_token: auth_token.decorate }
  end
end