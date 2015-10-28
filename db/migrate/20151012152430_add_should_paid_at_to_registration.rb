class AddShouldPaidAtToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :should_paid_at, :datetime
  end
end
