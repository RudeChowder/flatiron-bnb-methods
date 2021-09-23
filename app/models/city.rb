class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, through: :listings

  include ReservationInfo::InstanceMethods
  extend ReservationInfo::ClassMethods

  def city_openings(start_date, end_date)
    openings(start_date, end_date)
  end
end

