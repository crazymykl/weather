require "rails_helper"

RSpec.describe "Forecast", type: :system do
  before(:each) do
    driven_by(:rack_test)
  end

  let(:address) { "1 Infinite Loop, Cupertino, CA" }

  it "displays the forecast for a given address" do
    visit forecast_path
    fill_in "address", with: address
    click_button "Get Forecast"

    expect(page).to have_current_path(forecast_path(address: address, commit: "Get Forecast"))
  end
end
