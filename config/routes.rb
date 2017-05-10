Rails.application.routes.draw do

  # Routes per le static_pages
  root 'static_pages#home'
 
  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contacts'

#devise_for :users
<<<<<<< HEAD
  devise_for :users, controllers: { sessions: 'users/sessions', 
  		:omniauth_callbacks => "users/omniauth_callbacks" }
=======
  devise_for :users, controllers: { sessions: 'users/sessions', :omniauth_callbacks => "users/omniauth_callbacks"  }
>>>>>>> mioBranch
  
end
