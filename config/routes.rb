Rails.application.routes.draw do
  get '/', to: 'tasks#index'
  get 'tasks/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
