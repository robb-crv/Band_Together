
Rails.application.routes.draw do

  # Routes per le static_pages
  root 'static_pages#home'

  get 'static_pages/home'

  get 'static_pages/about'

  get 'static_pages/contacts'

  get 'static_pages/test_log_out'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }

#Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'


end
