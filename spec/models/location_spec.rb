require 'rails_helper'

RSpec.describe Location, type: :model do
  let(:stub_address) { "stub_address" }

  it "is valid with all fields" do
    expect(valid_location).to be_valid
  end

  it "is invalid without the coordinates and zip code" do
    expect(invalid_location).to be_invalid
  end

  it "uses AddressLocator to facilitate .for_address" do
    expect(AddressLocator).to receive(:call).with(stub_address).and_return(valid_location)
    expect(Location.for_address(stub_address)).to eq(valid_location)
  end
end
