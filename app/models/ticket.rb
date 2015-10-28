class Ticket < ActiveRecord::Base
  belongs_to :event
  belongs_to :registration, :counter_cache => true
  belongs_to :ticket_type



  validates :name,      presence: true
  validates :email,     presence: true
  validates :cell_phone,     presence: true

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
