class AdvertismentController < ApplicationController

	before_action :authenticate_user!

	def index

	end

	def show

		if(!params[:id].nil?)
			@advertisment= Advertisment.find(params[:id])
		else
			redirect_to "/404"
		end

	end

	def new
		@band = Band.find(params[:band_id])
		puts @band.inspect
	end

	def create

		@advertisment= Advertisment.new(advertisment_params)

		if @advertisment.save

			redirect_to advertisment_show_path(:id => @advertisment.id)
		else
			render 'advertisment/new'
		end
	end

	private

  	def advertisment_params
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date, :band_id, :user_id)
   	end


end
