Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check

  resources :users
  resources :inventories, only: [:index, :create, :destroy]

  post 'mark_infected', to: 'infection_registers#create'

end
