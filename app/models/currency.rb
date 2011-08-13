require 'money'

class Currency < ActiveRecord::Base
  
  default_scope :order => 'currencies.char_code ASC'
  
  validates :name, :presence => true
  validates :num_code,  :presence => true, :uniqueness => true, :numericality => true
  validates :char_code, :presence => true, :uniqueness => true
  validates :nominal, :numericality => true
  validates :value,   :numericality => true
  
  def base?
    self.char_code == self.class.base.char_code
  end
  
  class << self
    
    def get(char_code, base_code = Spree::Currency::Config[:base_currency])
      if currency = Currency.find_by_char_code(char_code.to_s.upcase)
        Money.add_rate(base_code, currency.char_code, currency.value.to_f)
        Money.add_rate(currency.char_code, base_code, currency.nominal/currency.value.to_f)
      end
      currency
    end
    
    # Session
    
    def init(char_code, base_code = Spree::Currency::Config[:base_currency])
      Thread.current[:base_currency]    = get(base_code)
      Thread.current[:current_currency] = get(char_code) || self.base
    end
    
    def base
      Thread.current[:base_currency]
    end
    
    def base?
      self.base == self.current
    end
    
    def current
      Thread.current[:current_currency]
    end
    
    # Conversion
    
    def convert(value, from, to)
      (Money.new(value.to_f * 10000, from).exchange_to(to).to_f / 100).round(2)
    end
    
    def convert_by_rate(value, rate)
      (value.to_f * rate.to_f).round(2)
    end
    
    def convert_to_current(value)
      convert(value, self.base.char_code, self.current.char_code)
    end
    
    def convert_from_current(value)
      convert(value, self.current.char_code, self.base.char_code)
    end
    
  end
  
end