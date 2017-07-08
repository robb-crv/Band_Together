class BandsController < ApplicationController

	before_action :authenticate_user!

	def index
		search = params[:search].present? ? params[:search] : nil
		@bands = if search
			Band.search(search)
		else
			Band.all
		end
	end

	def new
		@band = Band.new()
	end

	def create

		@band = Band.new(band_params)
		@band.band_manager = current_user

		if @band.save

			redirect_to band_path(@band)
			flash[:success] = "The band has been created successfully."
			UserAction.create(sender: current_user, action: "has created a new band called #{@band.name}!", receiver: @band)
		else

			render 'new'
		end
	end

	def show
			begin
				@band= Band.find(params[:id])
				@band_manager = User.find(@band.band_manager_id)
				@advs= Advertisment.where("band_id= ?", @band.id)
				@bandMembers = @band.users
				@active_users = @band.active_users
				@activities = @band.activities
				@followers= @band.followers
			rescue ActiveRecord::RecordNotFound
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
			redirect_to band_path( @band)
			flash[:success] = "Successfully updated informations."
			UserAction.create(sender: current_user, action: "has updated the informations of the band called #{@band.name}!", receiver: @band)
		else
			render 'edit'
		end
	end

	def destroy
		@band= Band.find(params[:id])
		#@bm= @band.band_manager.id

		if(@band.delete)

			flash[:success] = "The Band has been deleted correctly."
			redirect_to users_show_path(:id => current_user.id)
		else
			flash[:danger] = "An error occurred deleting band..."
		end

	end

	def leave_band

		band= Band.find(params[:band_id])
		id= band.id
		user= params[:user_id]

		@rel= MemberAssociation.where(user_id: user, joined_band_id: band.id).first
		@rel.destroy

		redirect_to band_path(band)

		flash[:success] = "you've left the band #{band.name}"
	end

	private
  	def band_params()
    	params.require(:band).permit(:name, :description, :musical_genre_id, :band_manager_id, :nation , :region, :city)
   	end

end
