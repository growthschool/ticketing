class TradeLog < ActiveRecord::Base
  serialize :content
  belongs_to :registration
end

# == Schema Information
#
# Table name: trade_logs
#
#  id              :integer          not null, primary key
#  content         :text
#  registration_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
