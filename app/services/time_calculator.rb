class TimeCalculator
  class << self
    SECONDS_IN_AVERAGE_YEAR = 365.25 * 24 * 60 * 60

    def years_ago time_from
      ((Time.zone.now - time_from.to_time) / SECONDS_IN_AVERAGE_YEAR).floor
    end
  end
end
