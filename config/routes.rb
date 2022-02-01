Rails.application.routes.draw do
  root 'encounters#index'

  get '(/encounters)/party_stats/(:id)', to: 'encounters#party_stats'
  get '/encounters/(:id/)party_stats/:id', to: 'encounters#party_stats'

  resources :monsters
  resources :encounters
  resources :parties

  post '(/encounters)/calculate_stats/', to: 'encounters#calculate_stats'
  post '/encounters/(:id/)calculate_stats/', to: 'encounters#calculate_stats'

  # search monsters
  resources :monsters_search, only: [:index]
end
