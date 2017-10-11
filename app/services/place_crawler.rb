module PlaceCrawler
  URL = 'https://restcountries.eu/rest/v2/capital/'

  def download_data
    open("#{ URL }#{ @city }").read
  end

  def download_and_parse_data
    JSON.parse(download_data, symbolize_names: true)
  end

  def download_places_data
    @places_data = download_and_parse_data.map { |data| PlaceData.new data }
  end
end
