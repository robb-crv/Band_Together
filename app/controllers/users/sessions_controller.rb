class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
 
  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create

    #.roberto estraggo lo user dal db con "where email=email_inserita"
    user= User.find_by(email: params[:session][:email].downcase) 

    #.roberto verifico che l'utente che ho estratto dal db corrisponda alla pwd inserita
    if user && user.authenticate(params[:session][:password])
      #.roberto  if true -> loggo l'utente
      log_in user
      redirect_to user
    else
      #.roberto altrimenti mostro messaggio d'errore
      # mostriamo un pop-up con flash.now[:danger]
      flash.now[:danger] = 'Email/password errati!'
      render 'new'
    end
  end

  # DELETE /resource/sign_out
  def destroy
    
    #user= User.find(params[:id])
    
    session[:user_id]= nil   
    @current_user = nil   
    flash[:success] = "user deleted"
    
    redirect_to root_path

  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
