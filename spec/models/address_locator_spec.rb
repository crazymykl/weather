require 'rails_helper'

RSpec.describe AddressLocator, type: :model do
  let(:found_valid_location) {
    VCR.use_cassette("valid_location_census") {
      AddressLocator.(valid_location.address)
    }
  }
  let(:found_invalid_location) {
    VCR.use_cassette("invalid_location_census") {
      AddressLocator.(invalid_location.address)
    }
  }

  it "should work with a valid address" do
    expect(found_valid_location).to eq(valid_location)
  end

  it "should return an invalid location with a blank address (without calling the API)" do
    expect(AddressLocator.(nil)).to eq(Location.new)
    expect(AddressLocator.("")).to eq(Location.new)
    expect(AddressLocator.(" ")).to eq(Location.new)

    expect(a_request(:any, //)).not_to have_been_made
  end

  it "should return an invalid location with an invalid address" do
    expect(found_invalid_location).to eq(invalid_location)
  end
end
