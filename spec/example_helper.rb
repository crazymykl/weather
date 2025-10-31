module ExampleHelper
  def invalid_location
    Location.new(address: "123 Fake St")
  end

  def valid_location
    Location.new(
      address: "1500 NEW BRITAIN AVE, FARMINGTON, CT, 06032",
      latitude: 41.713784491237,
      longitude: -72.861805345333,
      zip_code: "06032"
    )
  end

  def forecast_data
    {
      properties: {
        periods: [ {
          startTime: "1970-01-01T00:00:00Z",
          endTime: "1970-01-01T00:00:00Z",
          name: "name1",
          temperature: 1,
          temperatureUnit: "F",
          icon: "icon1",
          shortForecast: "4cast1",
          detailedForecast: "forecast1"
        }, {
          startTime: "1970-01-01T00:00:01Z",
          endTime: "1970-01-01T00:00:01Z",
          name: "name2",
          temperature: 2,
          temperatureUnit: "F",
          icon: "icon2",
          shortForecast: "4cast2",
          detailedForecast: "forecast2"
        } ]
      }
    }.deep_stringify_keys
  end
end

# def start_time
#   Time.parse(data["startTime"])
# end

# def end_time
#   Time.parse(data["endTime"])
# end

# def name
#   data["name"]
# end

# def temperature
#   "#{Float(data["temperature"])}°#{data["temperatureUnit"]}"
# end

# def icon
#   data["icon"]
# end

# def short_forecast
#   data["shortForecast"]
# end

# def detailed_forecast
#   data["detailedForecast"]
