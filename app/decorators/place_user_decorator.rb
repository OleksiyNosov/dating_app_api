class PlaceUserDecorator < ApplicationDecorator
  delegate_all

  decorates_association :place

  private
  def _only
    result = []

    result += %i[rating] if context[:user_user_ratings]

    result
  end

  def _methods
    %i[place]
  end
end
