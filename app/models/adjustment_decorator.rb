Adjustment.class_eval do

  def amount
    if associated_with_completed_order?
      read_attribute(:amount)
    else
      Currency.convert_to_current(read_attribute(:amount))
    end
  end
  
  def amount=(value)
    if associated_with_completed_order?
      write_attribute(:amount, value)
    else
      write_attribute(:amount, Currency.convert_from_current(value))
    end
  end
  
  protected
  
  def associated_with_completed_order?
    order && order.state == 'complete'
  end
  
end
