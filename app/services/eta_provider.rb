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
    car_area      = truncate position
    customer_area = truncate @position

    CacheManager.fetch [car_area, customer_area].flatten.to_s do
      haversine_distance car_area, customer_area
    end
  end


  protected

  def truncate position
    position.map {|coord| ('%.3f' % coord).to_f} # empirically derived
  end

  def haversine_distance car_area, customer_area
    Haversine.distance(car_area, customer_area).to_meters * 1.5
  end

end
