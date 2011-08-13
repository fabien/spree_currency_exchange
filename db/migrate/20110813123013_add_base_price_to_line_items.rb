class AddBasePriceToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :base_price, :float
    
    LineItem.update_all("base_price = price")
  end
 
  def self.down
    remove_column :line_items, :base_price
  end
end
