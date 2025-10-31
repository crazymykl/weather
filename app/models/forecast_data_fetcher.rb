class ForecastDataFetcher
  # Fetches forecast data from the Weather.gov API.
  #

  MAX_PRECISION = 4 # Maximum precision allowed for latitude and longitude
  CACHE_EXPIRATION = 30.minutes

  def self.client
    @_client ||= WeatherGovApi::Client.new
  end

  def self.call(location)
    return {} unless location.valid?

    Rails.cache.fetch("forecast_#{location.zip_code}", expires_in: CACHE_EXPIRATION) {
      location.assign_attributes(fresh: true)

      client.forecast(
        latitude: location.latitude.round(MAX_PRECISION),
        longitude: location.longitude.round(MAX_PRECISION)
      ).data
    }
  end
end
