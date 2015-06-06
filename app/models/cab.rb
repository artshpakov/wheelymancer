class Cab

  include Mongoid::Document

  field :position, type: Array
  field :available, type: Boolean

end
