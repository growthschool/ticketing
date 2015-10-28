class CreateOrderInfos < ActiveRecord::Migration
  def change
    create_table :order_infos do |t|
      t.string :order_id
      t.string :billing_name
      t.string :billing_address
      t.string :shipping_name
      t.string :shipping_address

      t.timestamps null: false
    end
  end
end
