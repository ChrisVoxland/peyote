class EarliestAvailableTimeslotFinder

  def initialize(user, minutes_required)
    @user = user
    @time_required = minutes_required
  end

  def run

  end
end

class TimeSlotResponse
  attr_reader :start_time, :end_time

  def initialize(start_time = nil, end_time = nil)
    @start_time = start_time
    @end_time = end_time
  end
end


# i'm trying to find gaps in events on a schedule
# i want to pull out all events that have a start time on or before a date
# I want to go through the end times for all of those
# if they all have end times on or before the end of the date being looked up
# then the user has free time on that day
# if there are activities with durations that can fit into these free time slots
# add them
