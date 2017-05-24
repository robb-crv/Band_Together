
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Routes per le static_pages
  root 'static_pages#home'

  get 'static_pages/home'




  get 'users/show'

  post 'users/show'

  get 'users/home'

  get 'advertisment/new'

  post 'advertisment/create'

  get 'band/new'

  post 'band/create'

  #resources :users, only: [:show, :edit, :update]
#Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }




end
