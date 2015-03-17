class OmniauthCallbacksController < ApplicationController
  def google_oauth2
    @user = User.find_or_create_for_google_oauth2(request.env["omniauth.auth"], current_user)

    if @user
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
      sign_in_and_redirect @user, :event => :authentication
    else
      redirect_to new_user_session_path, notice: 'Access Denied'
    end
  end

  def failure
    redirect_to root_path, notice: "shit fucked up yo"
  end
end
