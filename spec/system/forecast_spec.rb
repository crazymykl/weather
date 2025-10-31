require "rails_helper"

RSpec.describe "Forecast", type: :system do
  let(:valid_address) { valid_location.address }
  let(:invalid_address) { invalid_location.address }

  it "displays the address form" do
    visit forecast_path

    expect(page).to have_field("address")
    expect(page).to have_button("Get Forecast")
  end

  it "displays the forecast for a valid address, and caches it" do
    visit forecast_path
    fill_in "address", with: valid_address
    click_button "Get Forecast"

    expect(page).to have_css(".forecast")
    expect(page).to have_content(/Forecast for/i)
    expect(page).not_to have_content(/Cached/i)

    click_button "Get Forecast"
    expect(page).to have_content(/Forecast for/i)
    expect(page).to have_content(/Cached/i)
  end

  it "displays an error an invalid address" do
    visit forecast_path
    fill_in "address", with: invalid_address
    click_button "Get Forecast"

    expect(page).to have_css(".error")
    expect(page).to have_content(Location::ADDRESS_LOOKUP_ERROR)
  end
end
