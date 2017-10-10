class PlaceApiGenerator
  def initialize params
    @city = params[:city]
  end

  def download_and_create
    download_data

    create
  end

  def download_and_create_as_list
    Array.wrap download_and_create
  end

  private
  attr_reader :data, :city

  def download_data
    return unless city && city.present?

    raw_data = open("https://restcountries.eu/rest/v2/capital/#{ city }").read rescue return

    @data = JSON.parse(raw_data, symbolize_names: true).first
  end

  def create
    return if data.nil? || data[:capital].downcase != city.downcase

    Place.create! \
      name: data[:name],
      city: data[:capital],
      tags: generate_tags,
      lat: data[:latlng][0],
      lng: data[:latlng][1],
      overall_rating: generate_rating,
      place_id: ''
  end

  def generate_tags
    currencies = data[:currencies].map { |c| c[:code].downcase }

    currencies.push currencies.include?(:usd) ? 'soon' : 'maybe'
  end

  def generate_rating
    return 5 if data[:currencies].any? { |c| c[:code] == 'USD' }

    rand 1..4
  end
end
