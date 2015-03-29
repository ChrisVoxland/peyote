require 'rails_helper'

RSpec.describe SchedulesController, type: :controller do

  describe "Post #create" do
    it "returns http success" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end

end
