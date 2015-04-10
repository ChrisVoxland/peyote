class Schedule < ActiveRecord::Base
  belongs_to :user

  def latest_available_time_for_date(date)
    if date.saturday? || date.sunday?
      weekend_end_time
    else
      weekday_end_time
    end
  end

  def earliest_available_time_for_date(date)
    if date.saturday? || date.sunday?
      weekend_start_time
    else
      weekday_start_time
    end
  end
end
