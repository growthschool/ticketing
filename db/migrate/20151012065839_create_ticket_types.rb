class CreateTicketTypes < ActiveRecord::Migration
  def change
    create_table :ticket_types do |t|   
      t.string :name
      t.integer :event_id
      t.integer :price
      t.boolean :is_displayed, :default => true
      t.integer :amount
      t.timestamps null: false
    end
  end
end
