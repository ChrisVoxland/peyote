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
        access_token:  access_token.credentials.token,
        refresh_token: access_token.credentials.refresh_token
        
      )
    end
    user
  end
end
