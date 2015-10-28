class AddAgreeTermsToRegistration < ActiveRecord::Migration
  def change
    add_column :registrations, :agree_term_at, :datetime
  end
end
