Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users
  end
  root to: 'questions#index'
  resources :questions do
    resources :answers, only: [:create]
  end
  post '/questions/:id/answers', to: 'answers#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
