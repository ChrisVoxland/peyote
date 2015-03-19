class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:google_oauth2]

  has_many :events
  #TODO: Maybe rename to google_calendars. naming is weird..
  has_many :calendars

  #TODO: Pull tokens into separate class so user's aren't stuck with only one oath source

  #TODO: Do I want to update users every time this happens? Probably...

  #TODO: Should these methods be services? Probably
  # => OathUserCreationService
  # => UserCalendarWhateverService

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
        access_token:  access_token.credentials.token,
        refresh_token: access_token.credentials.refresh_token,
        expires_at: Time.at(access_token.credentials.expires_at)
      )
    end
    user
  end

  def fetch_writeable_calendars
    calendars = Google::Calendar.new(self).get_writeable_calendars
    calendars.each do |calendar|
      find_or_update_calendar(calendar)
    end
  end

  private

  def find_or_update_calendar(calendar)
    calendar_attributes = {
        calendar_id: calendar["id"],
        summary: calendar["summary"],
        access_role: calendar["access_role"],
        primary: calendar["primary"]
      }
    if existing_calendar = self.calendars.find_by_calendar_id(calendar["id"])
      existing_calendar.update_attributes(calendar_attributes)
    else
      self.calendars.create(calendar_attributes)
    end
  end
end
