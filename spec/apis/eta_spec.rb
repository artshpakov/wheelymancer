require 'spec_helper'

describe "ETA endpoint", type: :controller do
  include Rack::Test::Methods

  let(:cab) { create :cab }

  it "returns ETA in case of valid request" do
    get "/api/v1/eta", lat: cab.position.first+0.001, lng: cab.position.last-0.001
    expect(json_response.keys).to include('eta')
    expect(json_response['eta']).to be_a_kind_of(Float)
    expect(last_response.status).to eq(200)
  end

  it "returns 0 for exact match (sanity check)" do
    get "/api/v1/eta", lat: cab.position.first, lng: cab.position.last
    expect(json_response['eta']).to eq(0)
  end

  it "returns same ETA for close positions" do
    get "/api/v1/eta", lat: cab.position.first+0.0100, lng: cab.position.last+0.0100
    eta1 = json_response['eta']
    get "/api/v1/eta", lat: cab.position.first+0.0101, lng: cab.position.last+0.0101
    eta2 = json_response['eta']
    expect(eta1-eta2).to eq(0)
  end

end
