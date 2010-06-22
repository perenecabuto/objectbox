ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  map.myprofile '/myprofile', :controller => 'users', :action => 'myprofile'

  map.resources :postits
  map.resources :boards
  map.connect 'boards/:id', :controller => :boards, :action => :update, :method => :post
  map.resources :users
  map.resource :session
  map.resources :simpletexts

  map.root :controller => :object_collection

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
