class CreateCurrencies < ActiveRecord::Migration
  def self.up
    create_table :currencies do |t|
      t.string    :num_code, :null => false
      t.string    :char_code, :null => false
      t.string    :name, :null => false
      t.datetime  :date_req, :null => false
      t.decimal   :nominal, :precision => 8, :scale => 2, :null => false, :default => 1.0
      t.decimal   :value,   :precision => 8, :scale => 2, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :currencies
  end
end
