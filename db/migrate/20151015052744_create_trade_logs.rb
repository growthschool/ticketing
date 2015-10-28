class CreateTradeLogs < ActiveRecord::Migration
  def change
    create_table :trade_logs do |t|
      t.text :content
      t.integer :registration_id
      t.timestamps null: false
    end
  end
end
