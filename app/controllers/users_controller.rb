class UsersController < ApplicationController

  before_action :authenticate_user!

  #.roberto show user profile
  def show
  	@user = current_user
  end

  def home
    @user = current_user
  end


end
