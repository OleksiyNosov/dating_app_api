class AuthTokenDecorator < ApplicationDecorator
  ATTRS = %i[value]

  delegate_all

  private
  def _only
    ATTRS
  end
end
