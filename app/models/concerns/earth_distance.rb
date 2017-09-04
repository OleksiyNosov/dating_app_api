module EarthDistance
  include ActiveSupport::Concern

  def earth_distance_between lat1, lng1, lat2, lng2
    earth_radius = 6_371_000

    delta_lat = to_radians(lat2 - lat1)
    delta_lng = to_radians(lng2 - lng1)
    
    lat1 = to_radians lat1
    lat2 = to_radians lat2

    half_chord_square = Math.sin(delta_lat / 2)**2 + 
                        Math.cos(lat1) * 
                        Math.cos(lat2) * 
                        Math.sin(delta_lng)**2

    angular_distance = 2 * Math.atan2(Math.sqrt(half_chord_square), 
                                      Math.sqrt(1 - half_chord_square))

    earth_radius * angular_distance
  end

  def to_radians degrees
    degrees * Math::PI  / 180 
  end
end