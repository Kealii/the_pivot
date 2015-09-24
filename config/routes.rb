Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :items, only:[:index, :show, :new]
  resources :carts, only:[:show, :create]
  resources :items

  get '/cart', to: 'carts#show'
  get '/give', to: 'give#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/dashboard', to: 'sessions#show'
  delete '/logout', to: 'sessions#destroy'

  #content routes - manually done b/c no singular/plural distinction
  get '/content/new', to: 'content#new'
  post '/content/submit', to: 'content#create'
  patch '/content/submit', to: 'content#update'
  get '/content', to: 'content#index'
  get '/content/:id/edit', to: 'content#edit', as: 'edit_content'
  delete '/content/:id', to: 'content#destroy', as: 'delete_content'
end
