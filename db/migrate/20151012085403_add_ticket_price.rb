class AddTicketPrice < ActiveRecord::Migration
  def change
    add_column :tickets, :price, :integer
    add_column :registrations, :total_price, :integer
  end
end
