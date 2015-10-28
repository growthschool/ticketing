class AddInfoToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :name, :string
    add_column :registrations, :email, :string
    add_column :registrations, :cell_phone,:string
  end
end
