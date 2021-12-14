Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  namespace :admin do
    resources :users, only: %i[index destroy]
    resources :questions, only: %i[index destroy]
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
  end
  root to: 'questions#index'
  resources :users
  resources :questions do
    resources :answers, only: %i[create]
    collection do
      get 'search'
    end
  end
  post '/questions/:id/answers', to: 'answers#create'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
