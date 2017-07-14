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


		if @type == "invitation"

			@receiver = User.find_by username: params[:join_request][:receiver]

			if !@receiver.nil?

				#se receiver non ha gia un invito pendente
				if @band.pending_invitation(@receiver).empty?
					
					#se receiver non è gia membro
					if !@band.users.include? @receiver 

						@req= JoinRequest.new(:sender_id => current_user.id, :receiver_id => @receiver.id, :req_type => @type, :band_id => @band_id, :pending => true)

						if @req.save
							Notification.create(recipient: @receiver, actor: current_user, action: "send you invitation for #{@band.name}", notifiable: @band)
							flash[:success] = "invitation sent to #{@receiver.username}"
							redirect_to band_path(@band)
						else
							flash[:danger] = "An error occurred sending invitation"
							redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
						end

					else
						
						flash[:danger] = "user #{params[:join_request][:receiver]} is already a member!"
						redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
					end
				else 
					flash[:danger] = "you've already send invite for user #{params[:join_request][:receiver]}!"
					redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
				end			

			else
				flash[:danger] = "user #{params[:join_request][:receiver]} doesn't exists"
				redirect_to new_join_request_path(:band_id => @band, :req_type => @type)
			end
		
		elsif @type == "request"
			
			
			@receiver = User.find(params[:join_request][:receiver_id])
			
			@req= JoinRequest.new(:sender_id => current_user.id, :receiver_id => @receiver.id, :req_type => @type, :band_id => @band.id, :pending => true)
		
			if @req.save
				Notification.create(recipient: @receiver, actor: current_user, action: "send you a join request for #{@band.name}", notifiable: @band)
				flash[:success] = "the request has been sent to the band manager"
				redirect_to band_path(@band)
			else
				flash[:danger] = "An error occurred creating request for user #{@receiver.username}"
				redirect_to band_path(@band)
			end
		end
		
		
	end


	def accept

		@band = Band.find(params[:band_id])
		@sender= User.find(params[:sender_id])
		@receiver= current_user

	
		@rel = JoinRequest.where(sender_id: @sender.id, receiver_id: @receiver.id, band_id: @band.id)
		@rel.update_all(:pending => false)


		@ma= MemberAssociation.new(user_id: @receiver.id , joined_band_id: @band.id)

		if @ma.save
			
			Notification.create(recipient: @sender, actor: current_user, action: "has accepted your join request for #{@band.name}!", notifiable: @band)
			flash[:success] = "The request has been accepted"
			UserAction.create(sender: @sender, action: "has joined the band #{@band.name}!", receiver: @band)
			
			redirect_to band_path(@band.id)
		else 
			flash[:danger] = "error"
			redirect_to band_path(@band.id)
		end

	end

	def decline

		@rel = JoinRequest.where(sender_id: params[:sender_id], receiver_id: params[:receiver_id], band_id: params[:band_id])
		@rel.update_all(:pending => false)

		@band= Band.find(params[:band_id])
		@sender= User.find(params[:sender_id])
		Notification.create(recipient: @sender, actor: current_user, action: "hasn't accepted your join request for #{@band.name}", notifiable: @band)
		flash[:success] = "The request has been refused"
		redirect_to band_path(@band)
	end

	
	
end
