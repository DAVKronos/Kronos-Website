KronosWebsite::Application.routes.draw do

  resources :agendaitemtype_eventtypes

  resources :agendaitemtypes

  match '/kronobox' => 'kronobox#index'
  match '/elfinder' => 'kronobox#elfinder'

  devise_for :users
  resources :photos
  resources :comments
  resources :tags
  resources :photoalbums do
    resources :photos
  end
  resources :kronometers do
    collection do
      get 'labels'
    end
  end
  resources :news_items
  resources :subscriptions
  match '/users/xtracard', :to => 'users#xtracard'
  resources :users do
    get 'editpassword', :on => :member
  end
  match '/rebuildmailinglists', :to => 'users#update_mailinglists'
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
  match '/agendaitems/dag/:day', :to => 'agendaitems#perdag', :as => :perdag
  match '/wedstrijden', :to => 'agendaitems#wedstrijden'
  match '/uitslagen', :to => 'results#frontpage'
  resources :agendaitems do
    resources :events
    resources :results
    resources :comments
  end
  
  resources :events do
    resources :results
  end
  
  resources :results
  
  match '/home', :to => 'pages#home'
  match '/nieuw', :to => 'pages#nieuw'
  match '/test', :to => 'pages#test'
  match '/admin', :to => 'pages#admin'
  resources :pages
  match '/:pt', :to => 'pages#titleshow'
  
  root :to => 'pages#home'
end
