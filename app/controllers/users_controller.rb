class UsersController < ApplicationController

  before_action :authenticate_user!

  def show

    if(!params[:id].nil? )
  	   @user= User.find(params[:id])
    else
      redirect_to "/404"
    end
  end

  def home
    @user = current_user
  end

  #GET
  def edit_profile_informations
    @user = current_user
  end

  def update_profile_informations
    user = current_user
    updated = user.update_without_password(user_params)
    if updated
      redirect_to users_home_path
      flash[:success] = "Successfully updated informations."
    else
      redirect_to users_edit_profile_informations_path
      flash[:danger] = "Invalid parameters."
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:gender,:birth,:nation,:region, :city, :musical_genre, :type_of_musician)
  end

end
