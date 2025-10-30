class ForecastDataFetcher
  # Fetches forecast data from the Weather.gov API.
  #

  MAX_PRECISION = 4 # Maximum precision allowed for latitude and longitude

  def self.client
    @_client ||= WeatherGovApi::Client.new
  end

  def self.call(location)
    client.forecast(
      latitude: location.latitude&.round(MAX_PRECISION),
      longitude: location.longitude&.round(MAX_PRECISION)
    ).data
  end
end
