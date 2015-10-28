class AddLocationInfoToEvent < ActiveRecord::Migration
  def change
    add_column :events, :location_name, :string
    add_column :events, :location_address, :string
  end
end
