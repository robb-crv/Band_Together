class FollowingRelationshipsController < ApplicationController

	before_action :authenticate_user!

	def create
		@followed= User.find(params[:followed_id])
		current_user.follow(@followed)
		Notification.create(recipient: @followed, actor: current_user, action: "start following you!", notifiable: current_user)
		redirect_to users_show_path(:id => @followed)
		flash[:success] = "You're now following #{@followed.username}"
	end

	def destroy
		@followed= User.find(params[:followed_id])
		current_user.unfollow(@followed)	
		Notification.create(recipient: @followed, actor: current_user, action: "stop following you", notifiable: current_user)
		redirect_to users_show_path(:id => @followed)
		flash[:success] = "You're no longer following #{@followed.username}"
	end
end
