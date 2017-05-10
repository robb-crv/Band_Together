Rails.application.routes.draw do

  # Routes per le static_pages
  root 'static_pages#home'
 
  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contacts'

#devise_for :users
<<<<<<< HEAD
<<<<<<< HEAD
  devise_for :users, controllers: { sessions: 'users/sessions', 
  		:omniauth_callbacks => "users/omniauth_callbacks" }
=======
  devise_for :users, controllers: { sessions: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks"  }
>>>>>>> mioBranch
=======

  devise_for :users, controllers: { sessions: 'users/sessions', 
  									:omniauth_callbacks => "users/omniauth_callbacks" }  

#Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'
>>>>>>> 338633b88808169fc430271ce065852128b6567a
  
end
