UNAUTHORIZED_ERRORS = %i[inactive_user].freeze
SORT_DIRECTIONS = %i[asc ASC desc DESC].freeze


module RAPIDAPI
  HOST = "latest-stock-price.p.rapidapi.com".freeze
  BASE_URI = "https://#{HOST}".freeze
  SUCCESS_CODE = [*200..299].freeze
  DEFAULT_INDICE = "NIFTY NEXT 50".freeze

  module ENDPOINTS
    # same endpoint and params, no different between PRICE & PRICES
    PRICE = "#{BASE_URI}/price".freeze
    PRICES = "#{BASE_URI}/price".freeze
    PRICE_ALL = "#{BASE_URI}/any".freeze
  end
end
