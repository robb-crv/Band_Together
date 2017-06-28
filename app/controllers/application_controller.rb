class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

	before_action :configure_permitted_parameters, if: :devise_controller?

	helper_method :mailbox, :conversation

	#Code to catch CanCan::AccessDenied exception. This exception will be raised when user authorization fails

	rescue_from CanCan::AccessDenied do |exception|
      respond_to do |format|
        format.json { head :forbidden, content_type: 'text/html' }
        format.html { redirect_to main_app.root_path, notice: exception.message }
        format.js   { head :forbidden, content_type: 'text/html' }
      end
    end

	#Metodo che fornisce alla form un json con le regioni relative ad un dato stato

	def states
		render json: CS.states(params[:nation]).to_json()
	end

	def cities
		render json: CS.cities(params[:region],params[:nation]).to_json()
	end

	protected

	def configure_permitted_parameters

		devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :first_name, :last_name,
														   :gender, :birth, :nation, :password,
														   :password_confirmation, :region, :type_of_musician,
														   :musical_genre]
	end

	def after_sign_in_path_for(resource)
	  session["user_return_to"] || users_home_path
	end

	private

	def mailbox
		@mailbox ||= current_user.mailbox
	end

	def conversation
    	@conversation ||= mailbox.conversations.find(params[:id])
  	end
end
