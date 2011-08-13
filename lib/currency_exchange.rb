module CurrencyExchange
  
  def currency_exchange(*args)
    options = args.extract_options!
    [args].flatten.compact.each do |number_field|
      define_method(number_field.to_sym) do
        Currency.convert_to_current(read_attribute(number_field.to_sym))
      end
      unless options[:only_read]
        define_method(:"#{number_field}=") do |value|
          write_attribute(number_field.to_sym, Currency.convert_from_current(value))
        end
      end
    end
  end
  
end