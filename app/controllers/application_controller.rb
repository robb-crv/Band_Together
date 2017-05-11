class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	before_action :configure_permitted_parameters, if: :devise_controller?

	#Metodo che fornisce alla form un json con le regioni relative ad un dato stato

	def states
		render json: CS.states(params[:nation]).values.to_json()  	
	end

	protected

	def configure_permitted_parameters

		devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :first_name, :last_name,
														   :gender, :birth, :nation, :password,
														   :password_confirmation, :region, :type_of_musician,
														   :musical_genre]				 
	end
end
