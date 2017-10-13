module PlaceCrawler
  URL = 'https://restcountries.eu/rest/v2/capital/'

  class << self
    def download_data city
      open("#{ URL }#{ city }").read
    end

    def download_and_parse_data city
      JSON.parse(download_data(city), symbolize_names: true)
    end

    def download_places_data city
      download_and_parse_data(city).map { |data| PlaceData.new data }
    end
  end
end
