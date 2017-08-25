class UserDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    if context[:create]
      { user: user.decorate, auth_token: user.auth_tokens.last.decorate }
    else
      super only: _only, methods: _methods
    end
  end

  def full_name
    "#{ first_name } #{ last_name }"  
  end

  def coords
    { lat: lat, lng: lng }
  end

  def avatar_image
    { original_url: avatar.url, thumb_url: avatar.url(:thumb) }
  end

  private
  def _only
    %I[id email gender birthday]
  end

  def _methods
    %I[full_name coords avatar_image]
  end
end