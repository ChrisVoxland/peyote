require 'google/api_client'

#TODO: extract api stuff
#TODO: save status on event? or event log sort of thing?

class Event < ActiveRecord::Base
  belongs_to :user

  #TODO: BLEGHGHGHGH make this a serializer
  def jsonify
    json_structure = {
      'summary' => summary,
      'description' => description,
      'location' => location,
      'start' => { 'dateTime' => start_time.to_datetime.rfc3339 },
      'end' => { 'dateTime' => end_time.to_datetime.rfc3339 },
      'attendees' => [ 
        { "email" => 'bob@example.com' },
        { "email" =>'sally@example.com' }
      ]   
    }
    JSON.dump(json_structure)
  end
end
