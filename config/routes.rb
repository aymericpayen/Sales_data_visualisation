Rails.application.routes.draw do
  root to: 'superstores#index'
  resources :superstores, only: [ :index, :show ]
  # get "superstores/:state", to: "superstores#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
