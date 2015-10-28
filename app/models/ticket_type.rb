class TicketType < ActiveRecord::Base

  belongs_to :event

  validates :name,      presence: true
  validates :price,     presence: true

  has_many :tickets


  def available_amount
    if amount.present?
      amount - paid_tickets_count - still_can_pay_tickets_count- not_placed_and_not_expired_tickets_count
    end
  end

  def available_amount_range
    # 可以購買的票範圍數量
    if amount.present?
    #  1..available_amount
      0..available_amount
    else
      0..5
    end
  end

  def not_placed_and_not_expired_tickets_count
    tickets.joins(:registration).merge(Registration.not_placed.not_expired).count
  end

  def not_placed_and_expired_tickets_count
    tickets.joins(:registration).merge(Registration.not_placed.expired).count
  end

  def still_can_pay_tickets_count
    tickets.joins(:registration).merge(Registration.still_can_pay).count
  end

  def cant_paid_tickets_count
    tickets.joins(:registration).merge(Registration.cant_paid).count
  end

  def paid_tickets_count
    tickets.joins(:registration).merge(Registration.paid).count
  end
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
