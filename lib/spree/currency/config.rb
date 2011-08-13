module Spree::Currency
  class Config < Spree::Config
    class << self
      def instance
        return nil unless ActiveRecord::Base.connection.tables.include?('configurations')
        CurrencyConfiguration.find_or_create_by_name("Currency configuration")
      end
    end
  end
end