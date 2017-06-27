class ActivitiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @activity = Activity.new()
    @band = Band.find(params[:band_id])
  end

  def create
    @activity = Activity.new(activity_params)
    @band= Band.find(params[:band_id])

    @activity.band = @band
    @activity.band_manager = current_user

    if @activity.save
      redirect_to band_show_path(:id => @band.id)
      flash[:success] = "The activity has been created successfully."

    else
      render new_activity_path(:band_id => @band.id)
    end
  end

  def index
    @band = Band.find(params[:id])
    @activities = Activity.where(band: @band)

    respond_to do |format|
      format.json
      format.html { render 'index' }
    end
  end


  def show
    @activity = Activity.find(params[:id])
  end





  private
    def activity_params()
      params.require(:activity).permit(:title, :description, :location, :accessibility, :start_date, :duration, :start_hours)
    end

end
