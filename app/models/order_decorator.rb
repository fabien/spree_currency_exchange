Order.class_eval do
  
  belongs_to :currency
  
  before_validation :handle_currency_change
  
  alias_method(:update_without_currency_exchange!, :update!) unless method_defined?(:update_without_currency_exchange!)
  def update!
    handle_currency_change(true)
    update_without_currency_exchange!
  end
  
  def rate_hash
    @rate_hash ||= available_shipping_methods(:front_end).collect do |ship_method|
      next unless cost = ship_method.calculator.compute(self)
      { :id => ship_method.id,
        :shipping_method => ship_method,
        :name => ship_method.name,
        :cost => Currency.conversion_to_current(cost)
      }
    end.compact.sort_by{|r| r[:cost]}
  end
  
  protected
  
  def handle_currency_change(forced = false)
    self.currency ||= Currency.base
    
    if self.currency_id_changed? || forced
      return self.currency_id = self.currency_id_was if completed? # cop out
      
      self.currency_value   = self.currency.value
      self.currency_nominal = self.currency.nominal
      
      self.line_items.each do |item|
        price = item.price
        item.base_price = item.variant.base_price
        item.price = Currency.convert(item.base_price, Currency.base.char_code, self.currency.char_code)
      end
      
      Rails.logger.info "\n\n#{self.adjustment_total} VS #{adjustments.eligible.map(&:amount).sum}\n\n"
      
    end
  end
  
end