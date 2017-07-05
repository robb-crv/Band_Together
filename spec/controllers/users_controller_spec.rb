require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #show" do
    it "returns http success" do
      get :show
      		expect(response).to have_http_status(302)	
    end
  end

end
