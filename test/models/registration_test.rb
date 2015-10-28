require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: registrations
#
#  id             :integer          not null, primary key
#  event_id       :integer
#  token          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  name           :string
#  email          :string
#  cell_phone     :string
#  total_price    :integer
#  payment_method :string
#  paid_at        :datetime
#  tickets_count  :integer          default(0)
#  expired_at     :datetime
#  should_paid_at :datetime
#  canceled_at    :datetime
#  trade_number   :string
#  bank_code      :string
#  bank_no        :string
#  agree_term_at  :datetime
#
# Indexes
#
#  index_registrations_on_trade_number  (trade_number)
#
