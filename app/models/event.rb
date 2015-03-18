require 'google/api_client'

#TODO: extract api stuff
#TODO: save status on event? or event log sort of thing?

class Event < ActiveRecord::Base
  belongs_to :user

  def create_event_for_user(user)
    client.authorization.access_token = user.access_token
    service = client.discovered_api('calendar', 'v3')
    new_event = client.execute(
      api_method: service.events.insert,
      parameters: {
        "calendarId" => user.email,
        "sendNotifications" => false
      },
      :body => jsonify
      )
  end

  #TODO: BLEGHGHGHGH SERIALIZER
  def jsonify
    json_structure = {
      'summary' => summary,
      'description' => description,
      'location' => location,
      'start' => { 'dateTime' => (start_time + 3.hours).to_datetime.rfc3339 },
      'end' => { 'dateTime' => (end_time + 3.hours).to_datetime.rfc3339 },
      'attendees' => [ 
        { "email" => 'bob@example.com' },
        { "email" =>'sally@example.com' } 
      ]      
    }
    JSON.dump(json_structure)
  end

  private

  #TODO: Move this hit out into a separate class
  def client
    @client ||= Google::APIClient.new(
      application_name: "calendoer",
      application_version: "0.0.1"
    )
  end
end
