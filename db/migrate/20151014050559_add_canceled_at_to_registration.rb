class AddCanceledAtToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :canceled_at, :datetime
  end
end
