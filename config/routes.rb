
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

  # Routes per l'advertisement

  get 'advertisment/new'

  post 'advertisment/create'

  # Routes per le band

  get 'band/new'

  post 'band/create'

  get 'band/show'

  #resources :users, only: [:show, :edit, :update]

  #Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }

end
