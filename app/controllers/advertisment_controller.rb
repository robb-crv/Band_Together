class AdvertismentController < ApplicationController

	before_action :authenticate_user!
	
	def new
		render 'advertisment/new'
	end

	def create
		@curr = current_user
		@adv= @curr.advertisments.create(advertisment_params)
	end 


	private 
  	def advertisment_params
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date)
   	end

end
