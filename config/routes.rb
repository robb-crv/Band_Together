Rails.application.routes.draw do
  
  root 'static_pages#home'

  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contacts'

  #devise_for :users
  devise_for :users, controllers: { sessions: 'users/sessions' }

  
end
