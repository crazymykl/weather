require 'rails_helper'

RSpec.describe ForecastDataFetcher, type: :model do
  let(:valid_forecast_data) {
    VCR.use_cassette('forecast_data') {
      ForecastDataFetcher.(valid_location)
    }
  }

  it "fetches forecast data for a valid location" do
    period = valid_forecast_data.dig('properties', 'periods', 0)

    expect(period).to have_key('name')
    expect(period).to have_key('startTime')
    expect(period).to have_key('endTime')
    expect(period).to have_key('temperature')
    expect(period).to have_key('temperatureUnit')
    expect(period).to have_key('icon')
    expect(period).to have_key('shortForecast')
    expect(period).to have_key('detailedForecast')
  end

  it "fetches empty data for an invalid location (no API call)" do
    expect(ForecastDataFetcher.(invalid_location)).to eq({})
    expect(a_request(:any, //)).not_to have_been_made
  end
end
