KronosWebsite::Application.routes.draw do

  resource :user_session
  resources :users
  resources :commissions
  resources :commission_memberships
  
  
  match '/home', :to => 'pages#home'
  
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'
  match '/admin', :to => 'pages#admin'

  get "pages/contact"
  
  get "pages/about"
  
  root :to => 'pages#home'

end
