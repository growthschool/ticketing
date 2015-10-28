class Registration < ActiveRecord::Base

  

  belongs_to :event
  has_many :tickets
  has_many :trade_logs

  before_create :set_expired_time

  
  accepts_nested_attributes_for :tickets
  
  validates :name,      presence: true
  validates :email,     presence: true
  validates :cell_phone,     presence: true


  before_create :generate_token
  
  def generate_token
    self.token = SecureRandom.uuid
    self.trade_number = token.split("-").first
  end
  
  def with_bank_info?
    bank_code.present? && bank_no.present?
  end

  def order_number
    "#{self.id}_#{Time.now.to_i}"
  end

  def self.still_can_pay
    where.not(:should_paid_at => nil).where(:expired_at => nil).where("should_paid_at > ?", Time.now)
  end

  def self.cant_paid
    where.not(:should_paid_at => nil).where(:expired_at => nil).where("should_paid_at < ?", Time.now)
  end

  def self.paid
    where.not(:paid_at => nil)
  end

  def self.not_placed
    where(:should_paid_at => nil).where.not(:expired_at => nil)
  end

  def self.expired
    where.not(:expired_at => nil).where("expired_at < ?", Time.now )
  end

  def self.not_expired
    where.not(:expired_at => nil).where("expired_at > ? ", Time.now )
  end

  def self.already_canceled
    where.not(:canceled_at => nil)
  end

  def set_expired_time
    self.expired_at = Time.now + 15.minutes
  end
  
  def extend_expired_time!
    self.update_columns( :expired_at => Time.now + 1.hours )
  end


  def calculate_total!
    self.total_price = tickets.sum(:price)
    self.save(:validate => false )
  end


  def is_canceled?
    canceled_at
  end

  def expired?
    if expired_at.present?
      expired_at < Time.now
    end
  end
  
  def is_paid?
    paid_at.present?
  end

  def set_payment_with!(method)
    self.update_columns(payment_method: method, :should_paid_at => Time.now + 3.days, :expired_at => nil )
  end


  def pay!(paid_at=Time.now)
    self.update_columns(paid_at: paid_at, expired_at: nil, should_paid_at: nil  )
  end  

  def order_summaries
    "TODO"
  end

  def cancel!
    self.update_columns(:canceled_at => Time.now )
  end

  def filled_info?
    name.present? && email.present? && cell_phone.present?
  end

  def human_agree_term
    agree_term_at.present?
  end

  def human_agree_term=(value)
    

    write_attribute(:agree_term_at, time)
  end

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
