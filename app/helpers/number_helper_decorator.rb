module ActionView
  module Helpers
    module NumberHelper
      alias_method(:rails_number_to_currency, :number_to_currency) unless method_defined?(:rails_number_to_currency)
      def number_to_currency(number, options = {})
        options[:currency] ||= Currency.current.char_code.upcase
        defaults = { :locale => "currency_#{options[:currency]}" }
        rails_number_to_currency(number, defaults.merge(options))
      end
    end
  end
end