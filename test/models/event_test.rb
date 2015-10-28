require 'test_helper'

class EventTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: events
#
#  id               :integer          not null, primary key
#  name             :string
#  description      :text
#  seat_quantity    :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  is_displayed     :boolean          default(FALSE)
#  token            :string
#  location_name    :string
#  location_address :string
#  started_at       :datetime
#  end_at           :datetime
#
