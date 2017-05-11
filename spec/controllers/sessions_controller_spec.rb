require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do

	describe "POST new_user_session_path" do

		context 'with valid params' do
			it 'redirects to root_path'
		end

		context 'with invalid params' do
			it 're-render new_user_session_path'
		end
	end

end
