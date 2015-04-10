class Calendar < ActiveRecord::Base
  belongs_to :user
  has_many :events

  #TODO think about timezones
  def fetch_events
    api = Google::Calendar.new(user)
    events = api.get_future_events_from_calendar(self)
    events.each do |event|
      update_or_create_local_event(event)
    end
  end

  private

  def update_or_create_local_event(event)
    event_attributes = {
      event_id: event["id"],
      summary: event["summary"],
      description: event["description"],
      location: event["location"],
      start_time: event["start"].try(:[], "dateTime"),
      end_time: event["end"].try(:[], "dateTime"),
      user_id: user.id
    }
    if existing_event = events.find_by_event_id(event["id"])
      existing_event.update_attributes(event_attributes)
    else
      events.create(event_attributes)
    end
  end
end
