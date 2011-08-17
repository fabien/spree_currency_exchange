require 'spree_core'

module SpreeCurrencyExchange
  
  module ControllerSupport
    module InstanceMethods
      protected
      def init_currencies
        base_currency = Spree::Currency::Config[:base_currency]
        if self.is_a?(Admin::BaseController)
          Currency.init(base_currency, base_currency)
        elsif current_order.is_a?(Order) && current_order.currency
          Currency.init(current_order.currency.char_code, base_currency)
        else
          Currency.init(session[:current_currency] || base_currency, base_currency)
        end

        Rails.logger.info " [ Currency Base ] : #{Currency.base.char_code}"
        Rails.logger.info " [ Currency Current ] : #{Currency.current.char_code}"
      end
    end
    
    def self.included(receiver)
      receiver.send :include, InstanceMethods
      receiver.send :before_filter, 'init_currencies'
    end

  end
  
  class Engine < Rails::Engine
    engine_name 'spree_currency_exchange'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/**/*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Spree::BaseController.send(:include, ControllerSupport)
      UserPasswordsController.send(:include, ControllerSupport)
      UserRegistrationsController.send(:include, ControllerSupport)
      UserSessionsController.send(:include, ControllerSupport)
    end

    config.to_prepare &method(:activate).to_proc
  end

end

