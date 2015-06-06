require 'spec_helper'

describe "ETA endpoint", type: :controller do
  include Rack::Test::Methods

  let(:cab) { create :cab }

  it "returs ETA in case of valid request" do
    get "/api/v1/eta", lat: cab.position.first+0.001, lng: cab.position.last-0.001
    expect(json_response.keys).to include('eta')
    expect(json_response['eta']).to be_a_kind_of(Float)
    expect(last_response.status).to eq(200)
  end

  it "returs 0 for exact match (sanity check)" do
    get "/api/v1/eta", lat: cab.position.first, lng: cab.position.last
    expect(json_response['eta']).to eq(0)
  end

end
