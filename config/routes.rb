Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  namespace :admin do
    resources :users
  end
  resources :users,only:[:new,:create,:show]
  resources :sessions,only:[:new,:create,:destroy]
end