KronosWebsite::Application.routes.draw do

  resources :agendaitemtype_eventtypes

  resources :agendaitemtypes

  devise_for :users

  resources :reactions
  resources :photos
  resources :tags
  resources :photoalbums do
    resources :photos
  end
  resources :news_items
  resources :subscriptions
  resources :users do
    get 'editpassword', :on => :member
  end
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
  match '/uitslagen', :to => 'results#frontpage'
  resources :agendaitems do
    resources :events
    resources :results
  end
  resources :events
  
  match '/home', :to => 'pages#home'
  match '/nieuw', :to => 'pages#nieuw'
  match '/test', :to => 'pages#test'
  match '/admin', :to => 'pages#admin'
  resources :pages
  match '/:pt', :to => 'pages#titleshow'
  
  root :to => 'pages#home'
end
