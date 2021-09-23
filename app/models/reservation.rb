class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :guest_is_not_host, :listing_is_open, :checkin_before_checkout

  def guest_is_not_host
    if guest == listing.host
      errors.add(:guest_id, "cannot be the same as host_id")
    end
  end

  def listing_is_open
    return if checkin.nil? || checkout.nil?

    if !listing.open?(checkin, checkout)
      errors.add(:checkin, "overlaps with an existing reservation")
    end
  end

  def checkin_before_checkout
    return if checkin.nil? || checkout.nil?

    if checkin >= checkout
      errors.add(:checkout, "must be after check-in date")
    end
  end

  def overlap?(start_date, end_date)
    [end_date, checkout].min > [start_date, checkin].max
  end

  def duration
    checkout - checkin
  end

  def total_price
    listing.price * duration
  end
end
