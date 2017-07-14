class AdvertismentsController < ApplicationController
	include AdvertismentHelper
	before_action :authenticate_user!

	def index
    	search = params[:search].present? ? params[:search] : nil
    	@advertisments = if search
      		Advertisment.search search, where: where_data
    	else
      		Advertisment.all
    	end
  	end

	def show
		begin
			@advertisment= Advertisment.find(params[:id])
			@band = Band.find(@advertisment.band_id)
			@band_manager= User.find(@band.band_manager_id)
			@bandMembers = @band.users
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
				UserAction.create(sender: @band, action: "has created a new advertisement called #{@advertisment.title}!", receiver: @advertisment)
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
			UserAction.create(sender: @band, action: "has updated the advertisement #{@advertisment.title}!", receiver: @advertisment)
			flash[:success] = "Successfully operation"
		else
			render 'edit'
		end

	end

	def destroy

		@adv= Advertisment.find(params[:id])
		if(@adv.delete)
    		flash[:success] = "The advertisment has been deleted correctly."
				UserAction.create(sender: @band, action: "has removed the advertisement #{@adv.title}!", receiver: @advertisment)
    		redirect_to band_path(@adv.band)
    	end
	end

	private

  	def advertisment_params
  		mus= musicians_sym
    	params.require(:advertisment).permit(:title, :description, :start_date, :term_date, :band_id, :user_id, :musicians => mus )
   	end

   	def where_data
	    data = Hash.new
	    filtering_ad_params(params).each do |key, value|
	      data[key] = value if value.present?
	    end
	    start_date_handler(params, data)
	    term_date_handler(params, data)
	    puts(data)
	    data      
  	end

  	def filtering_ad_params(params)
    	params.slice(:band_genre_id, :band_id, :band_manager_id)    
  	end

  	def start_date_handler(params, hash)
		data = params.slice(:con_start_date, :start_date)
		if data[:con_start_date].present? && data[:start_date].present?
		hash[:start_date] = {data[:con_start_date].to_sym => data[:start_date]}  
		end
		hash  	
  	end

  	def term_date_handler(params, hash)
	  	data = params.slice(:con_term_date, :term_date)
	  	if data[:con_term_date].present? && data[:term_date].present?
	  		hash[:term_date] = {data[:con_term_date].to_sym => data[:term_date]}  
	  	end
	  	hash  	
  	end


   	#:musicians => [:drummer, :lead_guitarist, :rhythmic_guitarist, :bass_guitarist, :keyboardist, :singer, :winds]

end
