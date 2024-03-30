Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users, only: [:index, :create, :destroy, :update, :show]
  resources :inventories, only: [:index, :create, :destroy]
  resources :exchanges, only: [:create]
  resources :reports, only: [:index]
  

  post 'mark_infected', to: 'infection_registers#create'

end
