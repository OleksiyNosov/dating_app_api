class PlaceSearcher < ApplicationSearcher
  private
  def initialize_results
    @results = Place.all
  end

  def search_by_city city
    return unless city.present?

    @results = @results.where city: city
  end

  def search_by_tags tags
    return unless tags

    @results = @results.where('tags @> ARRAY[?]::varchar[]', tags)
  end

  def search_by_range range
    return unless range

    @results = @results.where build_query_by_range(@params[:user], km_to_m(range), 'places')
  end

  def build_query_by_range center, range, table
    earth_box = "earth_box(ll_to_earth(#{ center[:lat] }, #{ center[:lng] }), #{ range })"

    location = "ll_to_earth(#{ table }.lat, #{ table }.lng)"

    "#{ earth_box } @> #{ location }"
  end

  def km_to_m km
    km.to_i * 1000
  end
end