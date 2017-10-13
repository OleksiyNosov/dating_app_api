class PlaceDataDecorator < Draper::Decorator
  delegate_all

  def attributes
    return unless context[:restcountries_capital]

    {
      name: data[:name],
      city: data[:capital],
      tags: generate_tags,
      lat: data[:latlng][0],
      lng: data[:latlng][1],
      overall_rating: generate_rating,
      place_id: ''
    }
  end

  private
  def generate_tags
    currencies = data[:currencies].map { |c| c[:code].downcase }

    currencies.push currencies.include?('usd') ? 'soon' : 'maybe'
  end

  def generate_rating
    return 5 if data[:currencies].any? { |c| c[:code] == 'USD' }

    rand 1..4
  end
end
