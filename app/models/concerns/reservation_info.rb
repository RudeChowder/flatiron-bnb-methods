module ReservationInfo

  module InstanceMethods
    def openings(start_date, end_date)
      query_datetimes = { start_date: start_date.to_datetime, end_date: end_date.to_datetime }
      listings.filter do |listing|
        listing.reservations.none? do |reservation|
          reservation.overlap?(query_datetimes)
        end
      end
    end
  end

  module ClassMethods
    def highest_ratio_res_to_listings
      all.max_by do |place|
        if place.listings.count.zero?
          0
        else
          place.reservations.count / place.listings.count
        end
      end
    end

    def most_res
      all.max_by { |place| place.reservations.count }
    end
  end
end
