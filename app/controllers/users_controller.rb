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



end
