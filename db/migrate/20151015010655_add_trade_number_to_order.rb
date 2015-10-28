class AddTradeNumberToOrder < ActiveRecord::Migration
  def change
    add_column :registrations, :trade_number, :string
    add_index :registrations, :trade_number
  end
end
