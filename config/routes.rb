KronosWebsite::Application.routes.draw do

  resources :subscriptions

  match '/eventtypes/:id/copy', :to => 'eventtypes#copy'
  resources :eventtypes

  resources :events

  resources :results

  get "chatmessages/archief"
  resources :chatmessages

  resource :user_session
  resources :users
  resources :commissions
  resources :commission_memberships
  resources :agendaitems
  resources :subscriptions
  
  match '/agendaitems/:id/results', :to => 'agendaitems#showresults'
  match '/agendaitems/:id/results/new', :to => 'agendaitems#newresults'
  match '/agendaitems/:id/results/edit', :to => 'agendaitems#editresults'
  
  match '/home', :to => 'pages#home'
  match '/nieuw', :to => 'pages#nieuw'
  match '/test', :to => 'pages#test'
  
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'
  match '/admin', :to => 'pages#admin'

  get "pages/contact"
  
  get "pages/about"
  
  root :to => 'pages#home'

end
