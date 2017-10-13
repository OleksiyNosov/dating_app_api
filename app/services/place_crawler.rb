module PlaceCrawler
  URL = 'https://restcountries.eu/rest/v2/capital/'

  class << self
    def places_data city
      @places_data ||= create_places_data city
    end

    private
    def download_raw_places city
      open("#{ URL }#{ city }").read
    end

    def parse_raw_places city
      JSON.parse(download_raw_places(city), symbolize_names: true)
    end

    def create_places_data city
      parse_raw_places(city).map { |data| PlaceData.new data }
    end
  end
end
