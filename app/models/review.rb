class Review < ActiveRecord::Base
  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  validates :rating, presence: true
  validates :description, presence: true
  validate :valid_past_reservation

  def valid_past_reservation
    if !reservation || reservation.status != "accepted" || reservation.checkout > Time.now
      errors.add(:reservation, "is not accepted, or is still in progress")
    end
  end
end
