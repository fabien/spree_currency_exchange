require 'exchange_services'

class Admin::CurrenciesController < Admin::ResourceController
  
  def synchronize
    if ExchangeService::update_rates(Spree::Currency::Config[:base_currency])
      flash[:notice] = t('manage_currencies.currencies_synchronized')
    else
      flash[:error] = t("manage_currencies.currencies_not_synchronized")
    end
    redirect_to admin_currencies_path
  end
  
end