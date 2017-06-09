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
	end

	def create

		@advertisment= Advertisment.new(advertisment_params)

		@advertisment.start_date = Time.now			#andrea start date prende la data corrente

		@advertisment.band_id= params[:band_id]
		@advertisment.user_id= current_user.id

		#salvataggio dell'hash contente i tipi richiesti nell'annuncio

		if @advertisment.save
			flash[:success] = "Successfully operation"
			redirect_to advertisment_show_path(:id => @advertisment.id)
		else
			flash[:danger] = "Invalid parameters"
			redirect_to advertisment_new_path(:band_id => params[:band_id])
		end
	end

	def edit
		@adv= Advertisment.find(params[:id])
	end

	def update

		@adv= Advertisment.find(params[:id])
		@adv.update(advertisment_params)
		redirect_to advertisment_show_path(:id => @adv.id)
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
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date, :band_id, :user_id)
   	end


end
