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

    @results = @results.select(build_select_query(@params[:current_user], 'places', 'distance'))
                       .where(build_where_query_by_range(@params[:current_user], km_to_miles(range.to_f), 'places'))
                       .order('distance')
  end
end