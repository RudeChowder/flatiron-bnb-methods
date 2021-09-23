class City < ActiveRecord::Base
  has_many :neighborhoods
  has_many :listings, :through => :neighborhoods
  has_many :reservations, through: :listings

  def city_openings(start_date, end_date)
    query_datetimes = { start_date: start_date.to_datetime, end_date: end_date.to_datetime }
    listings.filter do |listing|
      listing.reservations.none? do |reservation|
        reservation.overlap?(query_datetimes)
      end
    end
  end

  def self.highest_ratio_res_to_listings
    all.max_by { |city| city.reservations.count / city.listings.count }
  end

  def self.most_res
    all.max_by { |city| city.reservations.count }
  end
end

