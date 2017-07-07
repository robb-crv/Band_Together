class ReviewsController < ApplicationController

	before_action :authenticate_user!
	#before_filter :find_reviewable

	def new
		#@reviewable = User.find(params[:id])
		#@review = Review.new

		@reviewable = find_reviewable
		@review = Review.new
	end

	def create

		@review = Review.new(review_params)

		if @review.save
				#Notification.create(recipient: @reviewable, actor: current_user, action: "has sent you a feedback!", notifiable: current_user)
				flash[:success] = "Review correctly created"


				redirect_reviewable


		else
			redirect_to new_review_path(:id => @review.reviewable_id)
		end
	end


	private

	def redirect_reviewable
		param= params[:reviewable_type]
   		id= params[:id]

   		if param == "User"
  			redirect_to users_show_path(id: id)

  		elsif param == "Band"

  			redirect_to band_path(id: id)
  		else
  			redirect_to "/404"
  		end
	end

	#effettua la find a seconda che la richiesta arrivi
   	#per una Band o per un User
   	def find_reviewable

   		param= params[:reviewable_type]
   		id= params[:id]

   		if param == "User"
  			return User.find_by_id(id)

  		elsif param == "Band"

  			return Band.find_by_id(id)
  		else
  			return nil
  		end
	end

  	def review_params()
    	params.require(:review).permit(:rating, :description, :reviewer_id, :reviewable_id, :reviewable_type)
   	end

end
