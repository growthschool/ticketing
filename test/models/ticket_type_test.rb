require 'test_helper'

class TicketTypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: ticket_types
#
#  id                           :integer          not null, primary key
#  name                         :string
#  event_id                     :integer
#  price                        :integer
#  is_displayed                 :boolean          default(TRUE)
#  amount                       :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  allow_single_purchase_amount :integer          default(1)
#
