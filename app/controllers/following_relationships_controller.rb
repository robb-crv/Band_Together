class FollowingRelationshipsController < ApplicationController

	before_action :authenticate_user!

	def create
		followed= User.find(params[:followed_id])
		current_user.follow(followed)
		redirect_to users_show_path(:id => followed)
		flash[:success] = "You're now following #{followed.username}"
	end

	def destroy
		followed= User.find(params[:followed_id])
		current_user.unfollow(followed)	
		redirect_to users_show_path(:id => followed)
		flash[:success] = "You're no longer following #{followed.username}"
	end
end
