class Cab

  include Mongoid::Document
  include Mongoid::Indexable

  field :position, type: Array
  field :available, type: Boolean

  index position: '2dsphere'


  def self.nearby position, limit
    where(available: true).near_sphere(position: position).limit(limit).to_a
  end

end
