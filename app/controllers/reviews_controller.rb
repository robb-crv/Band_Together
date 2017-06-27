class ReviewsController < ApplicationController

	before_action :authenticate_user!

	def new
		@reviewed = User.find(params[:id])
		@review = Review.new
	end	

	def create
		
		@review = Review.new(review_params)
	 	@reviewed = User.find_by_id(@review.reviewed_id)

		if @review.save
				Notification.create(recipient: @reviewed, actor: current_user, action: "has sent you a feedback!", notifiable: current_user)
				flash[:success] = "Review correctly created"
				redirect_to users_show_path(:id => @review.reviewed_id)
		else 
			flash[:danger] = "---- RATING: #{@review.rating}, DESCRIPTION #{@review.description}, REVIEWED_ID: #{@reviewed.id}, CURRENT_USER: #{@review.reviewer_id} ----"
			#flash[:danger] = "oops...it seems to have already reviewed this user !"
			redirect_to reviews_new_path(:id => @review.reviewed_id)
		end
	end

	private
  	def review_params()
    	params.require(:review).permit(:rating, :description, :reviewer_id, :reviewed_id)
   	end
end

