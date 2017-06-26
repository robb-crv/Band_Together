class ActivitiesController < ApplicationController

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





  private
    def activity_params()
      params.require(:activity).permit(:title, :description, :location, :accessibility, :date, :duration, :start_hours)
    end

end
