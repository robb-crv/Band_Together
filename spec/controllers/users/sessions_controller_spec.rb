require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do

	scenario 'allow a user to log in' do

		render new_user_session_path	
		
  	end

end
=begin
	#qui devo creare un utente, in modo che sia presente nel db
	#passo alla form solo mail e password 

	describe "POST new_user_session_path" do

		user = FactoryGirl.create(:user, email:"roberto.caravelli@gmail.com")
		context 'user is registered' do

		end


		#se l'utente non è registrato
		context 'user is not registered in' do
			it 're-render new_user_registration_path'
		end
	end

end
=end