class AddPaymentMethod < ActiveRecord::Migration
  def change
    add_column :registrations, :payment_method, :string
    add_column :registrations, :paid_at, :datetime
  end
end
