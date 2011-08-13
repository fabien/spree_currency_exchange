require 'open-uri'
require 'nokogiri'

module ExchangeService
  class Base
  
    def initialize(currency_code)
      @base_currency_code = currency_code.upcase
    end
  
    def update_rates
    end
  
  end
end