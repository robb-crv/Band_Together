class JoinRequestsController < ApplicationController

	def show
		@joinRequest= JoinRequest.find_by_id(params[:id])
	end

	def new
		@type= params[:req_type]
		@band= Band.find(params[:band_id])
		@joinRequest = JoinRequest.new()
	end


	def create

		@type = params[:join_request][:req_type]
		@band_id = params[:join_request][:band_id]
		@band = Band.find(@band_id)
	

		@receiver = User.find_by username: params[:join_request][:receiver] 
		if @receiver.nil? 
			flash[:danger] = "user #{params[:join_request][:receiver]} does not exists"
			redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
			return
		end


		@req= JoinRequest.new(:sender_id => params[:join_request][:sender_id], :receiver_id => @receiver.id, :req_type => @type, :band_id => @band_id, :pending => true)
	
		if @req.save
			Notification.create(recipient: @receiver, actor: current_user, action: "send you invitation for #{@band.name}", notifiable: @band)
			flash[:success] = "invitation sent to #{@receiver.username}"
			redirect_to band_path(@band)
		else	
			flash[:danger] = @req.errors.full_messages
			redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
		end
		
	end


	def accept
		
		begin
			@receiver = User.find(params[:receiver_id])
			@type= params[:req_type]
			@band = Band.find(params[:band_id])
			@sender= User.find(params[:sender_id])			

			
		rescue ActiveRecord::RecordNotFound
			return 
		end	

		@rel = JoinRequest.where(:sender_id => @sender.id, :receiver_id => @receiver.id, :band_id => @band.id, :req_type => @type)
		@rel.update_all(:pending => false)
		

		if @type=="request"

			@ma= MemberAssociation.new(user_id: @sender.id , joined_band_id: @band.id)
		
		elsif @type=="invitation"
			@ma= MemberAssociation.new(user_id: @receiver.id , joined_band_id: @band.id)
		end

		if @ma.save
			
			Notification.create(recipient: @sender, actor: current_user, action: "has accepted your join request for #{@band.name}!", notifiable: @band)
			flash[:success] = "The request has been accepted"
			UserAction.create(sender: @sender, action: "has joined the band #{@band.name}!", receiver: @band)
			
			redirect_to band_path(@band.id)
		else 
			flash[:danger] = "An error occurred"
			redirect_to band_path(@band.id)
		end

	end

	def decline
		
		begin 
			@receiver = User.find(params[:receiver_id])
			@type = params[:req_type]
			@band= Band.find(params[:band_id])
			@sender= User.find(params[:sender_id])
		
		rescue ActiveRecord::RecordNotFound
			return 
		end

		@rel = JoinRequest.where(sender_id: @sender.id, receiver_id: @receiver.id, band_id: @band.id, req_type: @type)
		@rel.update_all(:pending => false)

		
		Notification.create(recipient: @sender, actor: current_user, action: "hasn't accepted your join request for #{@band.name}", notifiable: @band)
		flash[:success] = "The request has been refused"
		redirect_to band_path(@band)
	end

	
	
end
