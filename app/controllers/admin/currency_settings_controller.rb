class Admin::CurrencySettingsController < Admin::BaseController
  def update
    Spree::Currency::Config.set(params[:preferences])
    currency = Currency.get(Spree::Currency::Config[:base_currency])
    currency.update_attributes(:value => 1.0, :nominal => 1.0) if currency
    respond_to do |format|
      format.html {
        redirect_to admin_currency_settings_path
      }
    end
  end
end
