class EventSearcher < ApplicationSearcher
  private
  def initialize_results
    @results = Event.all
  end

  def search_by_start_date start_date
    search_between_dates if start_date.present?
  end

  def search_by_end_date end_date
    search_between_dates if end_date.present? && start_date.blank?
  end

  def search_between_dates
    start_date = @params[:start_date].present? ? @params[:start_date].to_time : Time.now
    end_date   = @params[:end_date].present?   ? @params[:end_date].to_time   : Time.now + 1.day

    @results = @results.where(start_time: start_date..end_date)
  end
end