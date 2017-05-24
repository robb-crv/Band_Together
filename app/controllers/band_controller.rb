class BandController < ApplicationController

	def new
		render 'band/new'
	end

	def create
	end

	private 
  	def advertisment_params
    	params.require(:band).permit(:name, :description, :musical_genre)
   	end
end
