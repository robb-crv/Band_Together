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
    @band= Band.find(params[:band_id])

    @activity.band = @band
    @activity.band_manager = current_user

    if @activity.save
      redirect_to band_path(@band)
      flash[:success] = "The activity has been created successfully."
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
