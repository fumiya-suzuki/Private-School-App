Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  # ログイン機能
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :users  do
    member do
      get 'edit_teacher'
      patch 'update_teacher'
    end
  end
  get '/new_teacher', to: 'users#new_teacher'
  post '/create_teacher', to: 'users#create_teacher'
  get '/index_teacher', to: 'users#index_teacher'
  get '/search', to: 'users#search'
end
