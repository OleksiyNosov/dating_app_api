class Api::UserRatingsController < ApplicationController
  before_action -> { set_decorator_context user_ratings: true }, only: :index

  private
  def collection
    parent
  end

  def parent
    parent_key = params.keys.detect { |k| k.match /(\w+)_id/ }

    parent_class = parent_key[0..-4].capitalize.constantize

    @parent = parent_class.find params[parent_key]
  end
end