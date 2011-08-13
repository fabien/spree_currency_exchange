class CurrencyController < Spree::BaseController
    
  def set
    if request.referer && request.referer.starts_with?("http://" + request.host)
      session["user_return_to"] = request.referer
    end
    
    bool = params[:currency] && currency = Currency.get(params[:currency])
    
    if bool && current_order.is_a?(Order)
      unless current_order.completed?
        Currency.init(currency.char_code)
        current_order.currency = currency
        bool = current_order.save # triggers callbacks
        current_order.update! if bool
      end
      session[:current_currency] = current_order.currency.char_code
    elsif bool
      session[:current_currency] = currency.char_code
    end
      
    if bool
      flash[:notice] = t(:currency_changed, :currency => currency.name)
    else
      flash[:error] = t(:currency_not_changed)
    end
    
    redirect_back_or_default(root_path)
  end
  
end
