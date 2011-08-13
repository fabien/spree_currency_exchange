class AddCurrencyToOrders < ActiveRecord::Migration
  def self.up
    add_column :orders, :currency_id, :integer
    add_column :orders, :currency_value, :float, :null => false
    add_column :orders, :currency_nominal, :float, :null => false, :default => 1
    
    currency = Currency.get(Spree::Currency::Config[:base_currency])
    Order.reset_column_information
    Order.all(:conditions => 'currency_id is NULL').each do |order|
      order.currency = currency
      order.currency_value = currency.value
      order.currency_nominal = currency.nominal
      order.save
    end
  end
 
  def self.down
    remove_column :orders, :currency_id
    remove_column :orders, :currency_value
    remove_column :orders, :currency_nominal
  end
end
