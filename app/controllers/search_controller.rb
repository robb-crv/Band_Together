class SearchController < ApplicationController

	before_action :authenticate_user!
	
	def index
    search = params[:search].present? ? params[:search] : nil
    @users = User.search search, where: user_where_data
    @advertisments = Advertisment.search search, where: ad_where_data
    @bands = Band.search(search)
    respond_to do |format|
			format.html 
			format.js 
    end
	end

  private

  def user_where_data
    data = Hash.new
    filtering_user_params(params).each do |key, value|
      data[key] = value if value.present?
    end
    age_handler(params, data)
    puts(data)
    data      
  end

  def ad_where_data
    data = Hash.new
    filtering_ad_params(params).each do |key, value|
      data[key] = value if value.present?
    end
    puts(data)
    data      
  end


  def filtering_user_params(params)
    params.slice(:gender, :musical_genre_id, :type_of_musician_id, :nation, :city)    
  end

  def filtering_ad_params(params)
    params.slice(:band_genre_id, :band_id)    
  end

  def age_handler(params, hash)
  	data = params.slice(:condition, :selected_age)
  	if data[:condition].present? && data[:selected_age].present?
  		hash[:birth] = {data[:condition].to_sym => Date.new((Time.current.year - Integer(data[:selected_age])), 1, 1)}  
  	end
  	hash
  end
end
