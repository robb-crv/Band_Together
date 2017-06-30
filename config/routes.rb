
Rails.application.routes.draw do

  #Definizione routes per RailsAdmin
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  # Routes per le static_pages
  root 'static_pages#home'

  get 'static_pages/home'

  #Routes per il controller della ricerca generica

  get '/search/index'

  # Routes per lo user

  get 'users/show'

  post 'users/show'

  get 'users/home'

  get 'users/index'

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

  #Routest per FollowingRelationship
  get 'following_relationships/create'
  post 'following_relationships/create'
  get 'following_relationships/destroy'
  post 'following_relationships/destroy'
  delete 'following_relationships/destroy'


  #Routes per Review
  get 'reviews/new'
  get 'reviews/create'
  post 'reviews/create'
  post 'reviews/destroy'
  delete 'reviews/destroy'

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


  #andrea. per la messaggistica

  # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  resources :conversations do
     member do
       post :reply
       post :trash
       post :untrash
     end
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end


  resources :activities



  #Route che serve nella form di signup per far apparire nella select della selezione della regione la lista delle regioni appartenenti alla nazione scelta dall'utente
  get '/states/:nation', to: 'application#states'

  #Route che serve nella form di signup per far apparire nella select della selezione della città la lista delle città appartenenti alla nazione e regione scelta dall'utente
  get  '/states/:nation/:region', to: 'application#cities'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
  									:omniauth_callbacks => "users/omniauth_callbacks" }


end
