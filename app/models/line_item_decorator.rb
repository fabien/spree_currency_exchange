LineItem.class_eval do
  
  def update_price!(currency)
    self.base_price = self.variant.base_price
    self.price = Currency.convert(self.base_price, Currency.base.char_code, (currency || self.order.currency).char_code)
  end
  
end