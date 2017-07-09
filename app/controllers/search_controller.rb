class SearchController < ApplicationController

	before_action :authenticate_user!
	
	def index
    search = params[:search].present? ? params[:search] : nil
    @users = User.search search, where: user_where_data
    @advertisments = Advertisment.search(search)
    @bands = Band.search(search)
	end

  private

  def user_where_data
    data = Hash.new
    filtering_user_params(params).each do |key, value|
      data[key] = value if value.present?
    end
    data      
  end


  def filtering_user_params(params)
    params.slice(:gender, :musical_genre_id)    
  end
end
