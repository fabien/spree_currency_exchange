Adjustment.class_eval do
  
  extend CurrencyExchange
  currency_exchange :amount
  
end
