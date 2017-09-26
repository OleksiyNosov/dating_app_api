class EventSearcher < ApplicationSearcher
  private
  def initialize_results
    @results = Event.where(kind: :public_event, user_id: @params[:current_user].id)
  end

  def search_by_start_date start_date
    search_between_dates if start_date.present?
  end

  def search_by_end_date end_date
    search_between_dates if end_date.present? && @params[:start_date].blank?
  end

  def search_by_range range
    @results = @results
      .joins(:place)
      .select(build_select_query(@params[:current_user], 'places', 'distance'))
      .where(build_where_query_by_range(@params[:current_user], km_to_miles(range.to_f), 'places'))
      .order('distance')                                          
  end

  def search_between_dates
    if @params[:start_date].present?
      start_date = @params[:start_date].to_time 
      end_date = @params[:end_date].present? ? @params[:end_date].to_time : start_date + 1.day
    else
      end_date = @params[:end_date].to_time 
      start_date = end_date - 1.day
    end

    @results = @results.where(start_time: start_date..end_date)
  end
end