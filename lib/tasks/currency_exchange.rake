# encoding: utf-8

require 'open-uri'
require 'nokogiri'
require 'exchange_services'

# add custom rake tasks here
namespace :spree_currency_exchange do
  
  namespace :rates do
    
    desc "Update currency rates from online service providers"
    task :update => :environment do
      currency_code = ENV['CURRENCY'] || Spree::Currency::Config[:base_currency]
      if ExchangeService.update_rates(currency_code)
        puts "Updated rates for base currency: #{currency_code}"
      else
        puts "Unable to update rates for base currency: #{currency_code}"
      end
    end
    
  end

  namespace :currency do
    
    desc "Load currency ISO4217 http://en.wikipedia.org/wiki/ISO_4217"
    task :iso4217 => :environment do
      date_req = Time.now
      url = "http://en.wikipedia.org/wiki/ISO_4217"
      data = Nokogiri::HTML.parse(open(url))
      keys = [:char_code, :num_code, :discharge, :name, :countries]
      data.css("table:eq(2) tr")[1..-1].map{|d|
        Hash[*keys.zip(d.css("td").map {|x| x.text.strip }).flatten]
      }.each { |n|
        n[:date_req] = date_req
        n[:value] = 1.0
        n[:nominal] = 1.0
        Currency.find_by_num_code(n[:num_code]) || Currency.create(n.except(:discharge).except(:countries))
      }
    end
    
  end

end