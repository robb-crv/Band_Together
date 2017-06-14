class SearchController < ApplicationController

	def index
	    search = params[:search].present? ? params[:search] : nil
	    @result = Searchkick.search(search, index_name: [User, Band, Advertisment])       
  	end
end
