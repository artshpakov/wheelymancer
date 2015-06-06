require 'spec_helper'

describe "Eta Provider" do

  subject { EtaProvider.new(0,0) }


  before :all do
    3.times { create :cab }
  end

  it "hits data storage on first request" do
    expect(subject).to receive(:haversine_distance).and_call_original.once
    subject.calculate_for [0,0]
  end

  it "hits cache storage on later requests" do
    expect(subject).not_to receive(:haversine_distance)
    subject.calculate_for [0,0]
  end

end
