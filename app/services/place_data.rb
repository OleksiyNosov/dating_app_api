class PlaceData
  include Draper::Decoratable

  attr_reader :data

  def initialize data
    @data = data
  end
end
