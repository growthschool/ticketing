class AddBankInfoToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :bank_code, :string
    add_column :registrations, :bank_no, :string
  end
end
