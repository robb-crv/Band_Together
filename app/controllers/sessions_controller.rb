class SessionsController < ApplicationController

	#.roberto new è legata alla view del log_in
  def new
  end

  #.roberto HTTP POST
  def create

  	#.roberto estraggo lo user dal db con "where email=email_inserita"
  	user = GenericUser.find_by(email: params[:session][:email].downcase)

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

  #.roberto HTTP DELETE
  def destroy
  end

end
