[
  [55.767954, 37.613649],
  [55.779263, 37.601096],
  [55.777453, 37.602448],
  [55.773072, 37.604508],
  [55.781266, 37.599315]
].each do |position|
  Cab.create position: position, available: true
end

Cab.last.update_attributes available: false

Cab.create_indexes
