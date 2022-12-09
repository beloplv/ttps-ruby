Rails.application.routes.draw do
  resources :branch_offices_schedules
  resources :turns
  devise_for :users
  resources :branch_offices
  resources :schedules
  resources :localities
  resources :users, path: '/users_administrator'

  get 'index/home'
  get 'index/index'
  root "index#home"
end
