require 'exchange_services/cbr'
require 'exchange_services/ecb'
require 'exchange_services/google'

module ExchangeService
  
  def self.update_rates(currency_code)
    services = Hash.new(::ExchangeService::Google)
    services['EUR'] = ::ExchangeService::Ecb
    services['RUB'] = ::ExchangeService::Cbr
    services[currency_code.upcase].new(currency_code).update_rates
  end
  
end