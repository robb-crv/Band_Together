class UsersController < ApplicationController

  before_action :authenticate_user!

  def show

    if(!params[:id].nil? )
      begin
        @user = User.find(params[:id])
        @createdBands = @user.bands
        @joinedBands = @user.joined_bands
      rescue ActiveRecord::RecordNotFound
        redirect_to "/404"
      end
    else
      redirect_to "/404"
    end
  end

  def index
    search = params[:search].present? ? params[:search] : nil
    @users = if search
    	User.search(search, where: where_data)
    else
      User.all
    end
  end

  def events
    @activities = current_user.activities_of_interest.where(:accessibility => "Public")

    respond_to do |format|
      format.json
    end
  end

  def home
    @interesting_actions = current_user.actions_of_interest
    @interesting_advertisments = current_user.advertisments_of_interest
  end

  #GET
  def edit_profile_informations
    @user = current_user

  end

  def update_profile_informations
    @user = current_user
    updated = @user.update_without_password(user_params)
    if updated
      redirect_to users_home_path
      flash[:success] = "Successfully updated informations."
      UserAction.create(sender: current_user, action: "has just updated the profile informations", receiver: nil)
    else
      render users_edit_profile_informations_path
    #  flash[:danger] = "Invalid parameters : " + user.errors.full_messages
    end
  end



  private

  def user_params
    params.require(:user).permit(:first_name,:last_name,:gender,:birth,:nation,:region, :city, :musical_genre_id, :type_of_musician_id)
  end

=begin
  
Metodi utilizzati per creare query dinamiche per searchkick. Il metodo where_data ritorna un hash contenente le where 
conditions da passare alla search. L'hash data è composto da tuple che hanno come chiave il simbolo corrispondente ad 
uno degli scope definiti nel model e per valore true. Facendo in questo modo searchkick aggiunge la clausola definita
nel model al where. Il metodo fitering_params prende solo i parametri di cui siamo interessati dall'hash params 
passatogli dalla view tramite form. 
  
=end 

  def where_data
    data = Hash.new
    filtering_params(params).each do |key, value|
    	if value.present?
    		if value.class == Hash
    			data[key] = values[key]
    		else
    			data[key] = value
    		end
    	end
    	age_handler(params, data)
    	data      
  	end     
  end


  def filtering_params(params)
    params.slice(:gender, :musical_genre_id, :type_of_musician_id, :nation, :region, :city)    
  end

  def age_handler(params, hash)
  	data = params.slice(:condition, :selected_age)
  	if data[:condition].present? && data[:selected_age].present?
  		hash[:birth] = {data[:condition].to_sym => Date.new((Time.current.year - Integer(data[:selected_age])), 1, 1)}  
  	end
  	hash
  end

end
