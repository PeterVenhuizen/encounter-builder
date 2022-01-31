Rails.application.routes.draw do
  root 'encounters#index'

  resources :monsters
  resources :encounters
  resources :parties

  post '(/encounters)/calculate_party_stats/', to: 'encounters#calculate_party_stats'
  post '(/encounters)/calculate_stats/', to: 'encounters#calculate_stats'
  post '/encounters/(:id/)calculate_party_stats/', to: 'encounters#calculate_party_stats'
  post '/encounters/(:id/)calculate_stats/', to: 'encounters#calculate_stats'

  # search monsters
  resources :monsters_search, only: [:index]
end
