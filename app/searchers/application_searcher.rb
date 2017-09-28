class ApplicationSearcher
  include SimpleMathOperations

  def initialize params={}
    @params = params
  end

  def search
    initialize_results

    @params.each do |attribute, value|
      next if attribute == :current_user

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

  def build_select_query center, table, field 
    center_point = build_point_from center.lng, center.lat

    table_point = build_point_for table

    "*, #{ center_point } <@> #{ table_point }::point AS #{ field }"
  end

  def build_where_query_by_range center, range, table
    center_point = build_point_from center.lng, center.lat

    location = build_point_for table

    "#{ center_point } <@> #{ location } <= #{ range }"
  end

  def build_point_from lng, lat
    "point(#{ lng }, #{ lat })"
  end

  def build_point_for table
    "point(#{ table }.lng, #{ table }.lat)"
  end

  def user
    @user ||= @params[:current_user]
  end
end