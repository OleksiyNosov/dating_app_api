module SimpleMathOperations
  include ActiveSupport::Concern
  
  def km_to_m km
    km * 1_000
  end

  def m_to_km m
    m / 1_000
  end
end