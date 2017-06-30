class JoinRequestsController < ApplicationController

	def index
		JoinRequest.all
	end

	def create

		@band = Band.find(params[:band_id])
		@receiver = User.find(params[:receiver_id])
		
		JoinRequest.create(join_request_params)
		Notification.create(recipient: @receiver, actor: current_user, action: "send you a join request for #{@band.name}", notifiable: @band)
		
		flash[:success] = "the request has been sent to the band manager"
		redirect_to :back
	end

	def destroy
	end

	def join_request_params()
    	params.permit(:band_id, :sender_id, :receiver_id, :pending)
   	end
end
