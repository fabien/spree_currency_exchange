class AddBasePriceToLineItems < ActiveRecord::Migration
  def self.up
    add_column :line_items, :base_price, :decimal, :precision => 12, :scale => 6, :null => false

    LineItem.update_all("base_price = price")
  end
 
  def self.down
    remove_column :line_items, :base_price
  end
end