class NotificationsController < ApplicationController
    before_action :authenticate_user!


   def index
       if params[:read].nil?
         @notifications = Notification.where(recipient: current_user).unread
       else
         @notifications = Notification.where(recipient: current_user)
       end
       respond_to do |format|
         format.json { render json: @notifications.to_json() }
         format.html { render 'index' }
       end
   end

   def mark_as read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update.all(read_at: Time.zone.now)
    render json: {success: true}
  end

end
