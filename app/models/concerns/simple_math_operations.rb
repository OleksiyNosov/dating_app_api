module SimpleMathOperations
  include ActiveSupport::Concern

  def km_to_m km
    km * 1000.0
  end

  def m_to_km m
    m / 1000.0
  end

  def km_to_miles km
    km / 1.60934
  end

  def miles_to_km miles
    miles * 1.60934
  end
end
