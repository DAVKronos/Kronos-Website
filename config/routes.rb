KronosWebsite::Application.routes.draw do
  
  resource :user_session
  resources :users
  
  
  match '/home', :to => 'pages#home'
  
  match '/signin', :to => 'user_sessions#create'
  match '/signout', :to => 'user_sessions#destroy'

  get "pages/contact"
  
  get "pages/about"
  
  root :to => 'pages#home'

end
