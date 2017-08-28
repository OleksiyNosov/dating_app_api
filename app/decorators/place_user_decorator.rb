class PlaceUserDecorator < ApplicationDecorator
  delegate_all

  def place
    object.place.decorate
  end

  private
  def _only
    result = []

    result += %I[rating] if context[:user_ratings]

    result
  end

  def _methods
    %I[place]
  end
end