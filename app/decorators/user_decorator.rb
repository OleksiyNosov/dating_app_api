class UserDecorator < ApplicationDecorator
  delegate_all

  def as_json *args
    if context[:create]
      { user: user.decorate(context: { full: true }), auth_token: user.auth_tokens.last.decorate }
    else
      super only: _only, methods: _methods
    end
  end

  def full_name
    "#{ first_name } #{ last_name }"  
  end

  def age
    years  = DateTime.now.year - birthday.year
    y_days = DateTime.now.yday - birthday.yday
    
    y_days < 0 ? years - 1 : years
  end

  def coords
    { lat: lat, lng: lng }
  end

  def avatar_image
    { original_url: avatar.url, thumb_url: avatar.url(:thumb) }
  end

  private
  def _only
    result = %I[id gender]

    result += %I[email birthday] if context[:full]

    result
  end

  def _methods
    result = %I[full_name avatar_image]

    result += %I[coords] if context[:full]

    result += %I[age] if context[:short]

    result
  end
end