require 'exchange_services/base'

class ExchangeService::Google < ExchangeService::Base
  
  def update_rates
    date_req = Time.now
    Currency.all.map do |currency|
      unless currency.char_code == @base_currency_code
        url = "http://www.google.com/ig/calculator?hl=en&q=1#{ currency.char_code }%3D%3F#{ @base_currency_code }"
        data = JSON.parse(open(url).read.gsub(/lhs:|rhs:|error:|icc:/){ |x| "\"#{x[0..-2]}\":"})
        if data["error"].blank?
          value = BigDecimal(data["rhs"].split(' ')[0])
          currency.update_attributes(:value => currency.nominal/value.to_f, :date_req => date_req)
        end
      end
    end.any?
  end
  
end