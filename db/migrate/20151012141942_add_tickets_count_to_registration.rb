class AddTicketsCountToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :tickets_count, :integer , :default => 0
  end
end
