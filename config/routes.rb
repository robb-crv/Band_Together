
Rails.application.routes.draw do

  #Definizione routes per RailsAdmin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Routes per le static_pages
  root 'static_pages#home'

  get 'static_pages/home'

  # Routes per lo user

  get 'users/show'

  post 'users/show'

  get 'users/home'

  get 'users/edit_profile_informations'

  post 'users/update_profile_informations'

  # Routes per l'advertisement

  get 'advertisment/index'

  get 'advertisment/show'

  get 'advertisment/new'

  post 'advertisment/create'

  post 'advertisment/destroy'

  delete 'advertisment/destroy'
  
  post 'advertisment/update'

  get 'advertisment/edit'

  
  # Routes per le band

  get 'band/new'

  post 'band/create'

  get 'band/show'

  get 'band/index'

  post 'band/destroy'

  delete 'band/destroy'

  get 'band/edit'

  post 'band/update'
  #resources :users, only: [:show, :edit, :update]

  #Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'

  #Route che serve nella form di signup per far apparire nella select della selezione della città la lista delle città appartenenti alla nazione e regione scelta dall'utente
  get  '/states/:nation/:region', to: 'application#cities'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }


end
