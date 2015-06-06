require 'spec_helper'

describe "Cab" do

  let(:cab) { create :cab }
  let(:faraway_cab) { create :cab, position: [59.935921, 30.322252] }
  before :each do
    Cab.create_indexes
  end

  context :nearby do
    it "locates only nearby cabs" do
      locale_nearby_cabs!
      expect(@nearby_cabs).to include(cab)
      expect(@nearby_cabs).not_to include(faraway_cab)
    end

    it "locates only available cabs" do
      cab.update_attributes available: false
      locale_nearby_cabs!
      expect(@nearby_cabs.count).to eq(0)
    end
  end

  def locale_nearby_cabs!
    @nearby_cabs = Cab.nearby cab.position, 3
  end

end
