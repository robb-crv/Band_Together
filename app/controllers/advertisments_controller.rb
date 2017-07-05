class AdvertismentsController < ApplicationController
	include AdvertismentHelper
	before_action :authenticate_user!

	def index
    	search = params[:search].present? ? params[:search] : nil
    	@advertisments = if search
      		Advertisment.search(search)
    	else
      		Advertisment.all
    	end
  	end

	def show
		begin
			@advertisment= Advertisment.find(params[:id])
		rescue ActiveRecord::RecordNotFound
			 redirect_to "/404"
		end
	end


	def new
		@band = Band.find(params[:band_id])
		@advertisment = Advertisment.new(band: @band)
	end

	def create
		if params[:band_id] == nil || params[:band_id] == ''
			flash[:danger] = "Can't create an advertisment, miss band ID."
			redirect_to users_home_path
			return
		end

		@advertisment = Advertisment.new(advertisment_params)



			@band = Band.find(params[:band_id])

			@advertisment.start_date = Time.now			#andrea start date prende la data corrente

			@advertisment.band_id= params[:band_id]
			@advertisment.user_id= current_user.id

			if @advertisment.save
				flash[:success] = "Successfully operation"
				redirect_to advertisment_path(@advertisment)
			else
				render 'new'
			end

	end

	def edit
		@advertisment= Advertisment.find(params[:id])
	end

	def update

		@advertisment= Advertisment.find(params[:id])
		if @advertisment.update(advertisment_params)
			redirect_to advertisment_path(@advertisment)
			flash[:success] = "Successfully operation"
		else
			render 'edit'
		end

	end

	def destroy

		@adv= Advertisment.find(params[:id])
		if(@adv.delete)
    		flash[:success] = "The advertisment has been deleted correctly."
    		redirect_to band_path(@adv.band)
    	end
	end

	private

  	def advertisment_params
  		mus= musicians_sym
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date, :band_id, :user_id, :musicians => mus )
   	end

   	#:musicians => [:drummer, :lead_guitarist, :rhythmic_guitarist, :bass_guitarist, :keyboardist, :singer, :winds]

end
