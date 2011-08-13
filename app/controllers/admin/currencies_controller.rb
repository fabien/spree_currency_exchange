require 'exchange_services'

class Admin::CurrenciesController < Admin::ResourceController
  
  def update_rates
    if ExchangeService::update_rates(Spree::Currency::Config[:base_currency])
    
    else
      
    end
  end
  
end