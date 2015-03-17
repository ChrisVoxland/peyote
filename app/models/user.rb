class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :events

  def self.find_or_create_for_google_oauth2(access_token, signed_in_resource = nil)
    data = access_token.info
    user = User.find_by_email(data["email"])
    unless user
      user = User.create(
        #name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        provider: access_token.provider,
        uid: access_token.uid,
        token:  access_token.credentials.token,
        refresh_token: access_token.credentials.refresh_token
        
      )
    end
    user
  end
end

# current_user = User.last
# @event = {
#   'summary' => 'New Event Title',
#   'description' => 'The description',
#   'location' => 'Location',
#   'start' => { 'dateTime' => (DateTime.now + 1.day).rfc3339 },
#   'end' => { 'dateTime' => (DateTime.now + 1.day + 1.hour).rfc3339 },
#   'attendees' => [ { "email" => 'bob@example.com' },
#   { "email" =>'sally@example.com' } ] }

# client = Google::APIClient.new
# client.authorization.access_token = current_user.token
# service = client.discovered_api('calendar', 'v3')

# @set_event = client.execute(:api_method => service.events.insert,
#                       :parameters => {'calendarId' => current_user.email, 'sendNotifications' => false},
#                       :body => JSON.dump(@event),
#                       :headers => {'Content-Type' => 'application/json'})
