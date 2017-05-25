class BandController < ApplicationController

	before_action :authenticate_user!

	def new
		render 'band/new'
	end

	def create
		
		@band = Band.create(band_params);
	end

	def show
		render 'band/show'
	end

	private 
  	def band_params()
    	params.require(:band).permit(:name, :description, :musical_genre)
   	end

end
