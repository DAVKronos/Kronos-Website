KronosWebsite::Application.routes.draw do

  resources :reactions
  resources :photos
  resources :tags
  resources :photoalbums do
    resources :photos
  end
  resources :news_items
  resources :subscriptions
  resources :users
  resources :commissions
  resources :commission_memberships
  resources :subscriptions
  
  match '/eventtypes/:id/copy', :to => 'eventtypes#copy'
  resources :eventtypes

  match '/chatmessages/archief', :to => 'chatmessages#archief'
  resources :chatmessages

  match '/newsitems/agree', :to => 'newsitems#agree'
  match '/newsitems/agreed/:id', :to => 'newsitems#agreed'
  resources :newsitems

  match '/agendaitems/archief', :to => 'agendaitems#archief'
  match '/wedstrijden', :to => 'agendaitems#wedstrijden'
  match '/uitslagen', :to => 'results#index'
  resources :agendaitems do
    resources :events
  end
  resources :events
  
  match '/signin', :to => 'user_sessions#new'
  match '/signout', :to => 'user_sessions#destroy'
  resource :user_session
  
  match '/home', :to => 'pages#home'
  match '/nieuw', :to => 'pages#nieuw'
  match '/test', :to => 'pages#test'
  match '/admin', :to => 'pages#admin'
  match '/pages/edit/:pt', :to => 'pages#edit'
  match '/pages/update/:pt', :to => 'pages#update'
  match '/:pt', :to => 'pages#show'
  
  root :to => 'pages#home'
  
  #Redirect all other requests toot ErrorsController for rendering 404 pages
  #This should be the last route
  match '*a', :to => 'errors#routing'
end
