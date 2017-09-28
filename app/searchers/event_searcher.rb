class EventSearcher < ApplicationSearcher
  private
  def initialize_results
    @results = Event.all
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
      .select("events.*, earth_distance(ll_to_earth(#{ user.lat }, #{ user.lng }), ll_to_earth(places.lat, places.lng)) AS distance")
      .where("earth_box(ll_to_earth(?, ?), ?) @> ll_to_earth(places.lat, places.lng)", user.lat, user.lng, range.to_f)
      .order('distance')
  end

  def search_between_dates
    @results = @results.where(start_time: start_date..end_date)
  end

  def start_date
    @start_date ||= @params[:start_date].present? ? @params[:start_date].to_time : Time.now
  end

  def end_date
    @end_date ||= @params[:end_date].present? ? @params[:end_date].to_time : start_date + 1.day
  end
end