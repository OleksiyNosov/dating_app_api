class AuthTokenDecorator < ApplicationDecorator
  delegate_all

  private
  def _only
    %I[value]
  end
end