Rails.application.routes.draw do
  get 'contacts/new'
  post "contacts/new"
  post 'contacts/create'
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
      get 'reports/admin_index'
    end
     patch 'attendances/update_one_month'
    resources :attendances
    resources :reports do
      member do
        patch 'admin_update'
      end
    end
    resources :tests do
      member do
        get 'show_subject'
      end
    end
  end
  get '/new_teacher', to: 'users#new_teacher'
  post '/create_teacher', to: 'users#create_teacher'
  get '/index_teacher', to: 'users#index_teacher'
  get '/search', to: 'users#search'
  
  post '/callback' => 'linebot#callback'
  

end
