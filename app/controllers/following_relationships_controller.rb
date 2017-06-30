class FollowingRelationshipsController < ApplicationController

	before_action :authenticate_user!

	def create

		@followable= find_followable
		@followable_type = @followable.class.name

		@rel = FollowingRelationship.new(follower_id: current_user.id, followable_id: @followable.id, followable_type: @followable_type.to_s) 

		if @rel.save

			send_notification_to_followable(@followable, @followable_type, "start following")

			redirect_to_followable_path(@followable, @followable_type)
			
			if @followable_type == "User"
				flash[:success] = "You're now following #{@followable.username}"
			elsif @followable_type == "Band"
				flash[:success] = "You're now following #{@followable.name}"
			end
		else 
			flash[:danger] = "An error occurred"
		end
	end

	def destroy

		@followable= find_followable	
		followable_type = @followable.class.to_s

		
		delete_followings_followable(@followable, followable_type)
		redirect_to_followable_path(@followable, followable_type)
		send_notification_to_followable(@followable, followable_type, "stop following")
		redirect_to_followable_path(followable_type, @followable.id)
		
	end




	private 

	def send_notification_to_followable(followable, type, text)
		
		if type == "User"
			
			Notification.create(recipient: followable, actor: current_user, action: text<< " you!", notifiable: current_user)
		elsif type == "Band"
			
			id = followable.id
			
			@band = Band.find_by_id(id)
			@set = @band.active_users
			
			@set.each do |user|
			
				if user!=current_user
					Notification.create(recipient: user, actor: current_user, action: text << " #{@band.name}!", notifiable: @band)	
				end
			end
		end
	end


	def redirect_to_followable_path(followable, type)

		if type == "User"

			redirect_to users_show_path(:id => followable.id)
			flash[:success] = "you're no longer following #{followable.username}"
		
		elsif type == "Band"
			
			redirect_to band_show_path(:id => followable.id)
			flash[:success] = "you're no longer following #{followable.name}"
		end
	end



	def delete_followings_followable(followable, type)

		if type == "User"

			if current_user.followings_users.include?(followable)
				current_user.followings_users.delete(followable.id)
			end
		elsif type == "Band"
			if current_user.followings_bands.include?(followable)
				current_user.followings_bands.delete(followable.id)
			end
		end
	end

	def find_followable

		type = params[:followable_type]
		id = params[:followable_id]

		if type == "User"
			return User.find_by_id(id)
		elsif type == "Band"
			return Band.find_by_id(id)
		else 
			return nil
		end
	end


	def review_params()
    	params.require(:following_relationships).permit(:follower_id, :followable_id, :followable_type)
   	end
end
