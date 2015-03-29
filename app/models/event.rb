#TODO: save status on event? or event log sort of thing?

class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :calendar

  #TODO make this logic correct. figure out how/when this is going to be called
  # scope :this_week, -> { where("start_time > ? AND end_time < ?", Date.beginning_of_week(:sunday), Date.beginning_of_week(:sunday) + 7.days) }

  def self.starting_on_or_earlier_than(date)
    comparison_date = date.end_of_day
    where("start_time <= ?", comparison_date)
  end

  def self.ending_on_or_later_than(date)
    comparison_date = date.end_of_day
    where("end_time >= ?", comparison_date)
  end

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
