class SearchController < ApplicationController

	before_action :authenticate_user!
	
	def index
    search = params[:search].present? ? params[:search] : nil
    @users = User.search search, {where: user_where_data, fields: user_fields, match: :word_start}
    @advertisments = Advertisment.search search, {where: ad_where_data, fields: ad_fields}
    @bands = Band.search search, {where: band_where_data, fields: band_fields}
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
    start_date_handler(params, data)
    term_date_handler(params, data)
    active_handler(params, data)
    puts(data)
    data      
  end

  def band_where_data
    data = Hash.new
    filtering_band_params(params).each do |key, value|
      data[key] = value if value.present?
    end
    puts(data)
    data      
  end

  #Metodi che ritornano l'array degli attributi da dare al campo fields della ricerca

  def user_fields
  	[:username, :email, :type_of_musician_name, :nation, :region, :city, :musical_genre_name]  	
  end

  def ad_fields
  	[{title: :text_middle}, {band_name: :word_start}, {band_manager_ad: :word_start}, {ad_genre_name: :word_start}, {description: :text_middle}]  	
  end

  def band_fields
  	[{name: :word_start}, {band_manager: :word_start}, {musical_genre_name: :word_start}, {band_nation: :word_start}, {band_region: :word_start}, {band_city: :word_start}, {description: :text_middle}]  	
  end

  #Metodi che filtrano params per prendere solamente i valori necessari alla ricerca

  def filtering_user_params(params)
    params.slice(:gender, :musical_genre_id, :type_of_musician_id, :nation, :region, :city)    
  end

  def filtering_ad_params(params)
    params.slice(:ad_genre_id, :band_name, :band_manager_ad)    
  end

  def filtering_band_params(params)
    params.slice(:band_manager, :band_genre_id, :band_nation, :band_region, :band_city)    
  end

  #Handlers di casi specifici

  def age_handler(params, hash)
  	data = params.slice(:condition, :selected_age)
  	if data[:condition].present? && data[:selected_age].present?
  		hash[:birth] = {data[:condition].to_sym => Date.new((Time.current.year - Integer(data[:selected_age])), 1, 1)}  
  	end
  	hash
  end

  def start_date_handler(params, hash)
  	data = params.slice(:con_start_date, :start_date)
  	if data[:con_start_date].present? && data[:start_date].present?
  		hash[:start_date] = {data[:con_start_date].to_sym => data[:start_date]}  
  	end
  	hash  	
  end

  def term_date_handler(params, hash)
  	data = params.slice(:con_term_date, :term_date)
  	if data[:con_term_date].present? && data[:term_date].present?
  		hash[:term_date] = {data[:con_term_date].to_sym => data[:term_date]}  
  	end
  	hash  	
  end

  def active_handler(params, hash)
  	if params[:active].present?
  		hash[:term_date] = {gte: Time.now.strftime("%Y-%m-%d")}
  	end 	
  	hash
  end
end
