require 'google/api_client'

class Google::Calendar
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def create_event(event)
    client.execute(
      api_method: calendar_api.events.insert,
      parameters: {
        "calendarId" => user.email,
        "sendNotifications" => false
      },
      :body => event.jsonify,
      :headers => {'Content-Type' => 'application/json'}
    )
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
    @client
  end
end
