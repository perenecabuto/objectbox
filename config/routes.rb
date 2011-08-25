# -*- encoding : utf-8 -*-
Objectbox::Application.routes.draw do
  resources :alerts
  resources :cooking_ingredients
  resources :cooking_recipes do
    resources :cooking_ingredients
  end

  resources :simpletexts
  resources :postits
  resources :boards do
    resources :postits
  end

  resources :users
  resource :session

  match 'boards/:id' => 'boards#update', :method => :post
  match '/search' => 'search#index', :as => :search
  match 'search/:q' => 'search#index'
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/login' => 'sessions#new', :as => :login
  match '/register' => 'users#create', :as => :register
  match '/signup' => 'users#new', :as => :signup
  match '/activate/:activation_code' => 'users#activate', :as => :activate
  match '/myprofile' => 'users#myprofile', :as => :myprofile
  match '/:controller(/:action(/:id))'

  root :to => 'object_collection#index'

end

