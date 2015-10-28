class Event < ActiveRecord::Base

  has_many :ticket_types
  has_many :registrations
  has_many :tickets
  
  scope :published, -> { where(:is_displayed => true )}

  accepts_nested_attributes_for :ticket_types, allow_destroy: true    , reject_if: proc { |attributes| attributes['name'].blank? && attributes['price'].blank? }


  validates :name,      presence: true
  validates :human_started_at, presence: true
  validates :human_end_at, presence: true
  
  before_create :generate_token
  
  def generate_token
    self.token = SecureRandom.uuid
  end


  def og_title
    ERB::Util.h(name)
  end

  attr_writer :current_step
  
  def current_step
    @current_step || steps.first
  end
  
  def steps
    %w[create_event set_ticket_type]
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end
  
  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end
  
  def first_step?
    current_step == steps.first
  end
  
  def last_step?
    current_step == steps.last
  end
  
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def publish!
    update_columns(is_displayed: true )
  end

  def make_draft!
    update_columns(is_displayed: false )
  end
  def available_seat

    if seat_quantity.present?
      seat_quantity - paid_tickets_count - still_can_pay_tickets_count - not_placed_and_not_expired_tickets_count
    else
      999
    end
  end


  def paid_tickets_count
    registrations.paid.sum(:tickets_count)
  end

  def not_placed_and_not_expired_tickets_count
    registrations.not_placed.not_expired.sum(:tickets_count)
  end

  def not_placed_and_expired_tickets_count
    registrations.not_placed.expired.sum(:tickets_count)
  end

  def still_can_pay_tickets_count
    registrations.still_can_pay.sum(:tickets_count)
  end

  def cant_paid_tickets_count
     registrations.cant_paid.sum(:tickets_count)
  end


  def human_now
   # Time.now.strftime("%Y-%m-%d %H:%M")
    ""
  end

  def human_started_at
    time = (started_at.present?) ? started_at.strftime("%Y-%m-%d %H:%M") : human_now
  end

  def human_started_at=(value)
    time = Time.zone.parse(value).presence || Time.zone.now

    write_attribute(:started_at, time)
  end

  def human_end_at
    time = (end_at.present?) ? end_at.strftime("%Y-%m-%d %H:%M") : human_now
  end

  def human_end_at=(value)
    time = Time.zone.parse(value).presence || Time.zone.now

    write_attribute(:end_at, time)
  end

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
