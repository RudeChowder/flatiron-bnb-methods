class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
  has_many :reservations, through: :listings

  include ReservationInfo::InstanceMethods
  extend ReservationInfo::ClassMethods

  def neighborhood_openings(start_date, end_date)
    openings(start_date, end_date)
  end
end
