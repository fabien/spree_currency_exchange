Adjustment.class_eval do
  extend CurrencyExchange
  currency_exchange :amount
  
  # TODO - check if these work as intended
  
end
