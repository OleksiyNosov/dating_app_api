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
    return unless range.present?

    @results = @results
      .select("places.*, earth_distance(ll_to_earth(#{ user.lat }, #{ user.lng }), ll_to_earth(places.lat, places.lng)) AS distance")
      .where("earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)", user.lat, user.lng, km_to_m(range.to_f))
      .order('distance')
  end
end