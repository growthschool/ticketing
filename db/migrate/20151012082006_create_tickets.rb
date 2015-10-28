class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :event_id
      t.integer :registration_id
      t.integer :ticket_type_id
      t.timestamps null: false
    end
  end
end
