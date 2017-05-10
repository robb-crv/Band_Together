class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

=begin  	
  La signup non andava a buon fine perchè devise presenta una funzione che specifica i parametri che sono
  ammessi alla registrazione. Tutti gli altri, evidentemente, vengono lasciati ad un valore null. 

  RezeR 	
=end
	
	before_action :configure_permitted_parameters, if: :devise_controller?

	protected

	def configure_permitted_parameters

		devise_parameter_sanitizer.permit :sign_up, keys: [:username, :email, :first_name, :last_name,
														   :gender, :birth, :nation, :password,
														   :password_confirmation, :region]

		#Anche per la sign in serve definire gli strong parameters (parametri ammessi)

		#devise_parameter_sanitizer.permit :login, keys: [:email, :password]				 
	end
  # .roberto
  # DEVISE  
  #forzatura per fare vedere all'utente la pagina di log_in se non è loggato 
  #TODO!

  #Metodo che fornisce alla form un json con le regioni relative ad un dato stato

  def states
  	render json: CS.states(params[:nation]).to_json()  	
  end

end
