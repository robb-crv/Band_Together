
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

  get 'users/events'

  post 'bands/leave_band'

  post 'join_requests/accept'
  post 'join_requests/decline'

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations',
                    :omniauth_callbacks => "users/omniauth_callbacks" }


  post 'following_relationships#unfollow' , to: 'following_relationships#unfollow' , as: :unfollow

  resources :advertisments
  resources :bands
  resources :following_relationships
  resources :reviews
  resources :join_requests

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




end
