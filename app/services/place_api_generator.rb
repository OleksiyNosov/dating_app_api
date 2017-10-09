class PlaceApiGenerator
  def initialize params
    @city = params[:city]
  end

  def upload_and_create
    upload_data_list

    create_if_not_exist
  end

  def upload_and_create_list
    Array.wrap upload_and_create
  end

  private
  def upload_data_list
    return unless @city && @city.present?

    @data_list = JSON.parse(open("https://restcountries.eu/rest/v2/capital/#{ @city }").read) rescue return
  end

  def create_if_not_exist
    return [] if @data_list.nil? || @data_list[0]['capital'] != @city

    create(@data_list[0]) unless exits @data_list[0]
  end

  def exits data
    PlaceSearcher.search(city: @city).any?
  end

  def create data
    Place.create! \
      name: data['name'],
      city: data['capital'],
      tags: generate_tags(data),
      lat: data['latlng'][0],
      lng: data['latlng'][1],
      overall_rating: generate_rating(data),
      place_id: ''
  end

  def generate_tags data
    currencies = data['currencies'].map { |c| c['code'].downcase }

    currencies.push currencies.include?('usd') ? 'soon' : 'maybe'
  end

  def generate_rating data
    return 5 if data['currencies'].any? { |c| c['code'] == 'USD' }

    rand 1..4
  end
end
