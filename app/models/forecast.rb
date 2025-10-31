class Forecast
  # Represents a forecast for a given location from the Weather.gov API

  class Period
    def initialize(data)
      @data = data
    end

    def start_time
      Time.parse(data["startTime"])
    end

    def end_time
      Time.parse(data["endTime"])
    end

    def name
      data["name"]
    end

    def temperature
      "#{Float(data["temperature"])}°#{data["temperatureUnit"]}"
    end

    def icon
      data["icon"]
    end

    def short_forecast
      data["shortForecast"]
    end

    def detailed_forecast
      data["detailedForecast"]
    end

    private

    attr_reader :data
  end

  attr_reader :location
  delegate :valid?, :errors, to: :location

  def self.for_address(address)
    new(Location.for_address(address))
  end

  def initialize(location)
    @location = location
    @data = ForecastDataFetcher.(location)
  end

  def periods
    data.dig("properties", "periods").to_a.map { Period.new(_1) }
  end

  private

  attr_reader :data
end
