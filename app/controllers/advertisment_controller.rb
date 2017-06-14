class AdvertismentController < ApplicationController
	include AdvertismentHelper
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
		@advertisment = Advertisment.new(band: @band)
	end

	def create

		@advertisment = Advertisment.new(advertisment_params)
		
		

			@band = Band.find(params[:band_id])

			@advertisment.start_date = Time.now			#andrea start date prende la data corrente

			@advertisment.band_id= params[:band_id]
			@advertisment.user_id= current_user.id

			if @advertisment.save
				flash[:success] = "Successfully operation"
				redirect_to advertisment_show_path(:id => @advertisment.id)
			else
				#flash[:danger] = "Invalid parameters"
				render advertisment_new_path
			end
		
	end

	def edit
		@advertisment= Advertisment.find(params[:id])
	end

	def update

		@advertisment= Advertisment.find(params[:id])
		if @advertisment.update(advertisment_params)
			redirect_to advertisment_show_path(:id => @advertisment.id)
			flash[:success] = "Successfully operation"
		else
			render advertisment_edit_path
		end

	end

	def destroy

		@adv= Advertisment.find(params[:id])
		if(@adv.delete)
    		flash[:success] = "The advertisment has been deleted correctly."
    		redirect_to band_show_path(:id => params[:band_id])
    	end
	end

	private

  	def advertisment_params
  		mus= musicians_sym
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date, :band_id, :user_id, :musicians => mus )
   	end

   	#:musicians => [:drummer, :lead_guitarist, :rhythmic_guitarist, :bass_guitarist, :keyboardist, :singer, :winds]

end
