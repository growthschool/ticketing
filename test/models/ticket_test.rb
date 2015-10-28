require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: tickets
#
#  id              :integer          not null, primary key
#  event_id        :integer
#  registration_id :integer
#  ticket_type_id  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  price           :integer
#  name            :string
#  cell_phone      :string
#  email           :string
#
