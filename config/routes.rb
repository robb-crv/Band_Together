
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Routes per le static_pages
  root 'static_pages#home'

  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contacts'

  get 'static_pages/user_home'

  get 'static_pages/test_log_out'

  get 'users/show'

  post 'users/show'

  get 'grayscales/index'

  #resources :users, only: [:show, :edit, :update]
#Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }




end
