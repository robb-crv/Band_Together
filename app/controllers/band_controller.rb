class BandController < ApplicationController

	before_action :authenticate_user!

	def index
		@bands = current_user.bands
	end

	def new
		@band = Band.new()
	end

	def create

		@band = Band.new(band_params)
		@band.band_manager = current_user

		if @band.save

			redirect_to band_show_path(:id => @band.id)
			flash[:success] = "The band has been created successfully."
		else

			render band_new_path
			#flash[:danger] = "Invalid parameters."
		end
	end

	def show

		if(!params[:id].nil?)
			@band= Band.find(params[:id])
		else
			redirect_to "/404"
		end
	end

	def edit
		@band= Band.find(params[:id])
	end


	def update
		@band= Band.find(params[:id])
		updated = @band.update(band_params)


		if updated
			redirect_to band_index_path(:id => @band.band_manager)
			flash[:success] = "Successfully updated informations."
		else
			render band_edit_path
		#  flash[:danger] = "Invalid parameters : " + user.errors.full_messages
		end
	end

	def destroy
		@band= Band.find(params[:id])
		@bm= @band.band_manager.id

		if(@band.delete)

			flash[:success] = "The Band has been deleted correctly."
			redirect_to band_index_path(:id => @bm)
		else
			flash[:danger] = "An error occurred deleting band..."
		end

	end

	private
  	def band_params()
    	params.require(:band).permit(:name, :description, :musical_genre_id, :band_manager_id, :nation , :region, :city)
   	end

end
