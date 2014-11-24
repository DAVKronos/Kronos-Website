KronosWebsite::Application.routes.draw do

  resources :apps_exceptions


  resources :agendaitemtype_eventtypes

  resources :agendaitemtypes

#  match '/kronobox' => 'kronobox#index'
#  match '/elfinder' => 'kronobox#elfinder'
  match '/apps' => 'kronobox#appshome'
  match '/apps/group/add' => 'kronobox#groupadd'
  match '/apps/group/remove' => 'kronobox#groupremove'
  
  devise_for :users
  match '/users/xtracard', :to => 'users#xtracard'
  resources :users do
    get 'editpassword', :on => :member
    get 'overview', on: :collection
  end

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

  match '/rebuildmailinglists', :to => 'users#update_mailinglists'
  resources :commissions
  resources :commission_memberships
  
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
  match '/agendaitems/new_result', :to => 'agendaitems#new_result'
  match '/agendaitems/create_result', :to => 'agendaitems#create_result', via: [:post]
  
  resources :agendaitems do
    resources :events
    resources :results
    resources :comments
	resources :subscriptions
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
