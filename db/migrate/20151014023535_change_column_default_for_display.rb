class ChangeColumnDefaultForDisplay < ActiveRecord::Migration
  def change
    add_column :events, :is_displayed, :boolean, :default => false
  end
end
