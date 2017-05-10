class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception
	include SessionsHelper

  #Metodo che fornisce alla form un json con le regioni relative ad un dato stato

  def states
  	render json: CS.states(params[:nation]).values.to_json()  	
  end

end
