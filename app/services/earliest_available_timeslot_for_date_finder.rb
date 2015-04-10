class EarliestAvailableTimeslotForDateFinder

  #TODO: should this be minutes required or some other way to measure?
  def initialize(user, date, minutes_required)
    @user = user
    @date = date
    @minutes_required = minutes_required
  end

  def run
    TimeSlotResponse.new(start_time, end_time)
  end

  private

  def start_time
    if events_on_date.any?
      #do complicated stuff
    else
      @user.schedule.earliest_available_time_for_date(@date)
    end
  end

  def end_time
    if events_on_date.any?
      #do complicated stuff
    else
      start_time + @minutes_required.minutes
    end
  end

  def events_on_date
    @user.events.starting_on_or_earlier_than(@date)
  end
end

class TimeSlotResponse
  attr_reader :start_time, :end_time

  def initialize(start_time = nil, end_time = nil)
    @start_time = start_time
    @end_time = end_time
  end

  def success?
    @start_time.present? && @end_time.present?
  end
end
