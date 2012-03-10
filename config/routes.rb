KronosWebsite::Application.routes.draw do

  resources :reactions

  resources :tags
  resources :photos
  resources :photoalbums
  resources :news_items
  resources :subscriptions
  resources :events
  resources :users
  resources :commissions
  resources :commission_memberships
  resources :subscriptions
  
  match '/eventtypes/:id/copy', :to => 'eventtypes#copy'
  resources :eventtypes

  match '/results/list', :to => 'results#list'
  resources :results

  match '/chatmessages/archief', :to => 'chatmessages#archief'
  resources :chatmessages

  match '/newsitems/agree', :to => 'newsitems#agree'
  match '/newsitems/agreed/:id', :to => 'newsitems#agreed'
  resources :newsitems
  
  match '/agendaitems/:id/results', :to => 'agendaitems#showresults'
  match '/agendaitems/:id/results/new', :to => 'agendaitems#newresults'
  match '/agendaitems/:id/results/edit', :to => 'agendaitems#editresults'
  match '/agendaitems/:id/addevents', :to => 'agendaitems#newevents'
  match '/agendaitems/wedstrijden', :to => 'agendaitems#wedstrijden'
  match '/agendaitems/archief', :to => 'agendaitems#archief'
  resources :agendaitems
  
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
