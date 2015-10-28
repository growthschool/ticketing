class AddTicketInfo < ActiveRecord::Migration
  def change
    add_column :tickets, :name, :string
    add_column :tickets, :cell_phone, :string
    add_column :tickets, :email, :string
  end
end
