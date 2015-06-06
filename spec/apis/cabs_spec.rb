require 'spec_helper'

describe "Cabs endpoint", type: :controller do
  include Rack::Test::Methods

  let(:cab) { create :cab }
  let(:sample_position) { ["55.0", "45.0"] }

  it "returs 204 in case of valid request" do
    put "/api/v1/cabs/#{ cab.id }"
    expect(last_response.status).to eq(204)
  end

  it "changes specified cab status" do
    expect {
      put "/api/v1/cabs/#{ cab.id }", available: false
    }.to change {
      Cab.find(cab.id).available
    }.from(true).to(false)
  end

  it "changes specified cab position" do
    expect {
      put "/api/v1/cabs/#{ cab.id }", position: sample_position
    }.to change {
      Cab.find(cab.id).position
    }.to(sample_position)
  end

  it "returns 404 if cab id is missing" do
    put "/api/v1/cabs/invalid_id"
    expect(last_response.status).to eq(404)
  end
end
