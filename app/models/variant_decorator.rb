Variant.class_eval do
  extend CurrencyExchange
  currency_exchange :price
  
  def base_price
    read_attribute(:price)
  end
  
end