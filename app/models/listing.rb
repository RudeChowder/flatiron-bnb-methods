class Listing < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations

  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood_id, presence: true

  after_create :hostify_user
  after_destroy :dehostify_user

  def average_review_rating
    reviews.average(:rating)
  end

  def open?(start_date, end_date)
    reservations.none? do |reservation|
      reservation.overlap?(start_date, end_date)
    end
  end

private

  def hostify_user
    host.update(host: true)
  end

  def dehostify_user
    host.update(host: false) if host.listings.count.zero?
  end
end
