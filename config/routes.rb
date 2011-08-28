KronosWebsite::Application.routes.draw do
  
  get "commission/new"

  get "commission/create"

  get "commission/edit"

  get "commission/update"

  get "commission/delete"

  resource :user_session
  resources :users
  
  
  match '/home', :to => 'pages#home'
  
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'

  get "pages/contact"
  
  get "pages/about"
  
  root :to => 'pages#home'

end
