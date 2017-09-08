class PlaceSearcher < ApplicationSearcher
  include SimpleMathOperations

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

    @results = @results.select build_select_query(@params[:user], 'places', 'distance')

    @results = @results.where build_where_query_by_range(@params[:user], km_to_miles(range.to_f), 'places')

    @results = @results.order 'distance'
  end

  def build_select_query center, table, field 
    center_point = build_point_from center[:lng], center[:lat]

    table_point = build_point_for table

    "*, #{ center_point } <@> #{ table_point }::point AS #{ field }"
  end

  def build_where_query_by_range center, range, table
    center_point = build_point_from center[:lng], center[:lat]

    location = build_point_for table

    "#{ center_point } <@> #{ location } <= #{ range }"
  end

  def build_point_from lng, lat
    "point(#{ lng }, #{ lat })"
  end

  def build_point_for table
    "point(#{ table }.lng, #{ table }.lat)"
  end
end