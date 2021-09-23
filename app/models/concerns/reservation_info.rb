module ReservationInfo

  module InstanceMethods
    def openings(start_date, end_date)
      listings.filter do |listing|
        listing.open?(start_date.to_datetime, end_date.to_datetime)
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
