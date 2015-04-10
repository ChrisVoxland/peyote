require 'rails_helper'

RSpec.describe OmniauthCallbacksController, type: :controller do

  describe "GET #google_oath2" do
    it "returns http success" do
      get :google_oath2
      expect(response).to have_http_status(:success)
    end
  end

end
