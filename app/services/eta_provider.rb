class EtaProvider

  CABS_LOOKUP_LIMIT = 3

  def initialize lat, lng
    @position = [lat, lng]
  end
  
  def average_for_nearby_cabs limit=CABS_LOOKUP_LIMIT
    cabs = Cab.nearby(@position, limit)
    cabs.map {|cab| calculate_for cab.position}.sum / cabs.count if cabs.any?
  end

  def calculate_for position
    Haversine.distance(position, @position).to_meters * 1.5
  end

end
