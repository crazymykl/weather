class Location
  # A Location represents a geographic location with an address, latitude,
  # longitude, and zip code.
  #
  # The latitude and longitude are required for the weather API.
  # The zip code is used as a cache key, per a business requirement.
  # Because zip codes are not of a consistent size or shape, it is an
  # odd choice. I would use a rounded version of the latitude and longitude
  # instead, since weather is local.

  include ActiveModel::API

  attr_accessor :address, :latitude, :longitude, :zip_code
  validates :address, presence: true
  validate :validate_address_parts, if: -> { address.present? }

  ADDRESS_LOOKUP_ERROR = "Could not locate address"

  def self.for_address(address)
    AddressLocator.(address)
  end

  private

  def validate_address_parts
    return if latitude.present? && longitude.present? && zip_code.present?
    errors.add(:base, ADDRESS_LOOKUP_ERROR)
  end
end
