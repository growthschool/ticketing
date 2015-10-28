class AddEventTime < ActiveRecord::Migration
  def change
    add_column :events,:started_at, :datetime
    add_column :events, :end_at, :datetime
  end
end
