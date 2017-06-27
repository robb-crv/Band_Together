class SearchController < ApplicationController

	before_action :authenticate_user!
	
	def index
	    search = params[:search].present? ? params[:search] : nil
	    @users = User.search(search)
	    @advertisments = Advertisment.search(search)
	    @bands = Band.search(search)
  	end
end
