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
		puts params.inspect
		@band= params[:band_id]
		render 'advertisment/new'
	end

	def create

		@band_id= params[:band_id]
		
		@advertisment= Advertisment.new(advertisment_params)
		@advertisment.band_id= @band_id
		@advertisment.user_id= current_user.id
			
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
