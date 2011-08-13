require 'exchange_services/base'

class ExchangeService::Ecb < ExchangeService::Base
  
  def update_rates
    return false unless @base_currency_code == 'EUR'
    url = 'http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml'
    data = Nokogiri::XML.parse(open(url))
    date_req = Date.strptime(data.xpath('gesmes:Envelope/xmlns:Cube/xmlns:Cube').attr("time").to_s, "%Y-%m-%d")
    data.xpath('gesmes:Envelope/xmlns:Cube/xmlns:Cube//xmlns:Cube').each do |exchange_rate|
      char_code      = exchange_rate.attribute("currency").value.to_s.strip
      value, nominal = exchange_rate.attribute("rate").value.to_f, 1
      
      unless char_code == @base_currency_code
        currency = Currency.get(char_code)
        currency && currency.update_attributes(:value => value, :nominal => nominal, :date_req => date_req)
      end
    end
    true
  end
  
end