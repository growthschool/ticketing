class AddAmountToTicketType < ActiveRecord::Migration
  def change
    add_column :ticket_types, :allow_single_purchase_amount, :integer, :default => 1
  end
end
