require 'rails_helper'

RSpec.describe Forecast, type: :model do
  describe "for an invalid location" do
    let(:forecast) { Forecast.new(invalid_location) }

    it "is invalid" do
      expect(forecast).not_to be_valid
    end

    it "has errors explaining the invalid location" do
      expect(forecast.errors.full_messages).to \
        include(Location::ADDRESS_LOOKUP_ERROR)
    end
  end

  describe "for a valid location" do
    let(:forecast) { Forecast.new(valid_location) }
    before(:each) do
      expect(ForecastDataFetcher).to \
        receive(:call).with(valid_location).and_return(forecast_data)
    end

    it "is valid" do
      expect(forecast).to be_valid
    end

    it "presents forecast data split by period" do
      expect(forecast.periods.length).to eq(2)
      first, second = forecast.periods
      expect(first.short_forecast).to eq("4cast1")
      expect(first.detailed_forecast).to eq("forecast1")
      expect(first.start_time).to eq(Time.at(0).utc)
      expect(first.end_time).to eq(Time.at(0).utc)
      expect(first.icon).to eq("icon1")
      expect(first.name).to eq("name1")
      expect(first.temperature).to eq("1.0°F")
      expect(second.short_forecast).to eq("4cast2")
      expect(second.detailed_forecast).to eq("forecast2")
      expect(second.start_time).to eq(Time.at(1).utc)
      expect(second.end_time).to eq(Time.at(1).utc)
      expect(second.icon).to eq("icon2")
      expect(second.name).to eq("name2")
      expect(second.temperature).to eq("2.0°F")
    end
  end
end
