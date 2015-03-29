class HomeController < SecureController
  def index
    @activities = current_user.activities
  end
end
