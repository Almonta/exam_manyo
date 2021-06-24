Rails.application.routes.draw do
  get 'sessions/new'
  # root to: '/'
  # resources :tasks do
  #   collection do
  #     get :/
  #   end
  # end
  resources :tasks
  get '/', to: 'tasks#index'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
