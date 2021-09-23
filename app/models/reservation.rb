class Reservation < ActiveRecord::Base
  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  def overlap?(start_date:, end_date:)
    [end_date, checkout].min > [start_date, checkin].max
  end

end
