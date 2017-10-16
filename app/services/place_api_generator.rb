class PlaceApiGenerator
  def initialize city
    @city = city
  end

  def download_and_create_place
    find_valid_place_data if places_data

    create_place if @place_data
  end

  private
  def find_valid_place_data
    @place_data = places_data.detect { |place_data| place_data.data[:capital] == @city }
  end

  def places_data
    PlaceCrawler.places_data @city
  end

  def create_place
    Place.create! @place_data.decorate(context: { restcountries_capital: true }).attributes
  end
end
