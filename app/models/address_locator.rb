class AddressLocator
  # We use the Census Bureau's Geocoding API to retrieve location information
  # information about a given address.
  #
  # https://geocoding.geo.census.gov/geocoder/Geocoding_Services_API.html
  #
  # We round the latitude and longitude to a precision of 4 decimal places,
  # as that's the maximum supported by the Weather API.

  ROOT_URL = "https://geocoding.geo.census.gov"
  ENDPOINT = "/geocoder/locations/onelineaddress"
  BENCHMARK = "Public_AR_Current" # The docs say this will always exist

  def self.client
    @_client ||= Faraday.new(url: ROOT_URL)
  end

  def self.call(address)
    location = Location.new(address:)
    response = client.get(ENDPOINT, {
      address:,
      benchmark: BENCHMARK,
      format: "json"
    })

    if response.success?
      location.attributes = response_attributes(response)
    end

    location
  end

  private

  def client
    self.class.client
  end

  def self.response_attributes(response)
    body = JSON.parse(response.body)
    return {} unless address_match = body.dig("result", "addressMatches", 0)

    {
      address: address_match.dig("matchedAddress"),
      latitude: address_match.dig("coordinates", "y"),
      longitude: address_match.dig("coordinates", "x"),
      zip_code: address_match.dig("addressComponents", "zip")
    }
  end
end
