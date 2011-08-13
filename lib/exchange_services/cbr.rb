require 'exchange_services/base'

class ExchangeService::Cbr < ExchangeService::Base
    
  def update_rates
    return false unless @base_currency_code == 'RUB'
    url = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=#{Time.now.strftime('%d/%m/%Y')}"
    data = Nokogiri::XML.parse(open(url))
    date_str = data.xpath("//ValCurs").attr("Date").to_s
    date_req = Date.strptime(date_str, (date_str =~ /\./ ? '%d.%m.%Y' : '%d/%m/%y'))
    data.xpath("//ValCurs/Valute").each do |valute|
      char_code  = valute.xpath("./CharCode").text.to_s
      num_code   = valute.xpath("./NumCode").text.to_s
      name       = valute.xpath("./Name").text.to_s
      value      = valute.xpath("./Value").text.gsub(',','.').to_f
      nominal    = valute.xpath("./Nominal").text
      
      unless char_code == @base_currency_code
        currency   = Currency.get(char_code)
        currency && currency.update_attributes(:value => value, :nominal => nominal, :date_req => date_req)
      end
    end
    true
  end
  
end