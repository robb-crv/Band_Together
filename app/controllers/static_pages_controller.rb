class StaticPagesController < ApplicationController

  def home
    if signed_in?
      redirect_to users_home_path
    end
  end


end
