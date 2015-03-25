require 'google/api_client'

class Google::Calendar
  attr_reader :user

  #TODO: Should this just be a bunch of class methods?
  def initialize(user)
    @user = user
  end

  #TODO: Deal with request failures
  def create_event(event)
    client.execute(
      api_method: calendar_api.events.insert,
      parameters: {
        "calendarId" => user.email,
        "sendNotifications" => false
      },
      :body => event.jsonify,
      headers: {'Content-Type' => 'application/json'}
    )
  end

  def get_event_from_calendar(calendar, event)
    response = client.execute(
      api_method: calendar_api.events.get,
      parameters: {
        "calendarId" => calendar.calendar_id,
        "eventId" => event.event_id
      },
      headers: {'Content-Type' => 'application/json'}
    )
    JSON.parse(response.body)
  end

  # TODO: dont pull all future events, limit scope
  def get_future_events_from_calendar(calendar)
    response = client.execute(
      api_method: calendar_api.events.list,
      parameters: {
        "calendarId" => calendar.calendar_id,
        "timeMin" => DateTime.now.rfc3339
      },
      headers: {'Content-Type' => 'application/json'}
    )
    JSON.parse(response.body)["items"]
  end

  def get_writeable_calendars
    response = client.execute(
      api_method: calendar_api.calendar_list.list,
      parameters: {
        "minAccessRole" => "writer"
      },
      headers: {'Content-Type' => 'application/json'}
    )
    JSON.parse(response.body)["items"]
  end

  private

  def calendar_api
    client.discovered_api('calendar', 'v3')
  end

  def client
    #TODO: probably shouln't hard code version and name
    return @client if @client
    @client = Google::APIClient.new(
      application_name: "calendoer",
      application_version: "0.0.1"
    )
    @client.authorization.access_token = user.access_token
    @client.authorization.refresh_token = user.refresh_token
    @client.authorization.expires_at = user.expires_at
    @client
  end
end
