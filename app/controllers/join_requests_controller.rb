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

	def update

		update()
	end

	def destroy
	end

	def accept
		
		@rel = JoinRequest.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id], band_id: params[:band_id])
		@rel.update_all(:pending => false)
		#@rel.save

		@band= Band.find(params[:band_id])
		@sender= User.find(params[:sender_id])

		@ma= MemberAssociation.new(user_id: params[:sender_id] , joined_band_id: params[:band_id])
			
		if @ma.save
			Notification.create(recipient: @sender, actor: current_user, action: "has accepted your join request for #{@band.name}!", notifiable: @band)
			flash[:success] = "The request has been accepted"
			redirect_to :back
		end
	end

	def decline
		
		@rel = JoinRequest.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id], band_id: params[:band_id])
		@rel.update_all(:pending => false)

		@band= Band.find(params[:band_id])
		@sender= User.find(params[:sender_id])
		
		Notification.create(recipient: @sender, actor: current_user, action: "hasn't accepted your join request for #{@band.name}!", notifiable: @band)
		flash[:success] = "The request has been declined"
		redirect_to :back
	end

	def join_request_params()
    	params.permit(:band_id, :sender_id, :receiver_id, :pending)
   	end
end
