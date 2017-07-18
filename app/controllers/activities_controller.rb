class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  

  def new
    @activity = Activity.new()
    @band = Band.find(params[:band_id])
  end

  def create
    if params[:band_id] == nil || params[:band_id] == ''
      flash[:danger] = "Can't create an activity, miss band ID."
      redirect_to users_home_path
      return
    end
    @activity = Activity.new(activity_params)
    @band = Band.find(params[:band_id])

    @activity.band = @band
    @activity.band_manager = current_user

    if @activity.save
      redirect_to band_path(@band)
      flash[:success] = "The activity has been created successfully."

      if @activity.accessibility == "Private"
        @users_to_notify = @band.active_users
      else
        @users_to_notify = @band.users_to_notify
        UserAction.create(sender: @band, action: "has created a new activity called '#{@activity.title}', scheduled on #{@activity.start_date.strftime("%B %d, %Y at %H:%M")}!", receiver: @activity)
      end

      @users_to_notify.delete current_user
      @users_to_notify.each do |usr|
          Notification.create(recipient: usr, actor: current_user, action: "has just created a new activity called '#{@activity.title}' in the band '#{@band.name}'!", notifiable: @activity)
      end

    else
      render new_activity_path
    end
  end

  def index
    @band = Band.find(params[:id])
    @activities = Activity.where(band: @band)

    respond_to do |format|
      format.json
    end
  end


  def show
      begin
        @activity = Activity.find(params[:id])
        @band = @activity.band
      rescue ActiveRecord::RecordNotFound
         redirect_to "/404"
      end
  end


  def edit
    @activity= Activity.find(params[:id])
    @band = @activity.band
  end

  def destroy
    @activity= Activity.find(params[:id])
    @band  = @activity.band

		if(@activity.destroy)

			flash[:success] = "The Activity has been deleted correctly."
			redirect_to band_path(@band)

      if @activity.accessibility == "Private"
        @users_to_notify = @band.active_users
      else
        @users_to_notify = @band.users_to_notify
        UserAction.create(sender: @band, action: "has removed the activity called '#{@activity.title}', scheduled on #{@activity.start_date.strftime("%B %d, %Y at %H:%M")}!", receiver: @activity)
      end

      @users_to_notify.delete current_user

      @users_to_notify.each do |usr|
          Notification.create(recipient: usr, actor: current_user, action: "has just removed the activity called '#{@activity.title}' in the band '#{@band.name}'!", notifiable: @band)
      end
		else
			flash[:danger] = "An error occurred deleting activity..."
		end

  end


  def update
    @activity= Activity.find(params[:id])
		updated = @activity.update(activity_params)


		if updated
			redirect_to activity_path(:id => @activity.id)
			flash[:success] = "Successfully updated informations."
		else
      @band = @activity.band
			render 'edit'
		end
  end





  private
    def activity_params()
      params.require(:activity).permit(:title, :description, :location, :accessibility, :start_date, :duration)
    end

end
