require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do

	describe "POST new_user_session_path" do


		#se l'utente non è registrato
		context '' do
			it 'redirects to root_path'
		end

		#se l'utente non è registrato
		context '' do
			it 're-render new_user_registration_path'
		end
	end

end
