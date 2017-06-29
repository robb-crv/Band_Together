class NotificationsController < ApplicationController
    before_action :authenticate_user!


   def index

       @notifications = Notification.where(recipient: current_user)

       respond_to do |format|
         format.json
         format.html { render 'index' }
       end
   end

   def mark_as_read
      @notifications = Notification.where(recipient: current_user).unread
      @notifications.update_all(read_at: Time.zone.now)
      render json: {success: true}
  end


  def destroy
    notification = Notification.find(params[:id])
    notification.destroy
    redirect_to notifications_path
  end

end
