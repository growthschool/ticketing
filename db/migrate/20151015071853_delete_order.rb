class DeleteOrder < ActiveRecord::Migration
  def change
    drop_table :orders
    drop_table :order_infos
    drop_table :order_items
  end
end
