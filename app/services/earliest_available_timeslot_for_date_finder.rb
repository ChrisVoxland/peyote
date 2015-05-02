#TODO: Do I want to make this more generic and allow the user
#      to set a preference for earlier/later?
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
      earliest_available_timeslot[:start_time]
    else
      @user.schedule.earliest_available_time_for_date(@date)
    end
  end

  def end_time
    if events_on_date.any?
      earliest_available_timeslot[:end_time]
    else
      start_time + @minutes_required.minutes
    end
  end

  def events_on_date
    @user.events.starting_on_or_earlier_than(@date)
  end

  def earliest_available_timeslot
    return {} unless events_ending_during_users_desired_time.any?
    events_ending_during_users_desired_time.each_with_index do |event, index|
      next_event = events_ending_during_users_desired_time[index + 1]
      if next_event && sufficient_time_between_events?(event, next_event)
        return { start_time: event.end_time, end_time: event.end_time + @minutes_required.minutes }
      end
    end
    {}
  end

  def events_ending_during_users_desired_time
    @events_ending_during_users_desired_time ||= events_on_date
      .where("end_time <= ?", @user.schedule.latest_available_time_for_date(@date))
  end

  def sufficient_time_between_events?(earlier_event, later_event)
    (later_event.start_time - earlier_event.end_time) / 60 >= @minutes_required
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
