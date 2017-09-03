class ApplicationSearcher
  def initialize_params params={}
    @params = params&.symbolize_keys || { }
  end

  def search
    initialize_results

    @params.each do |attribute, value|
      method_name = :"search_by_#{ attribute }"

      send method_name, value if respond_to?(method_name, true)
    end

    @results
  end

  private
  def initialize_results
    @results = []
  end

  class << self
    def search params={}
      new(params).search
    end
  end
end