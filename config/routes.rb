Rails.application.routes.draw do
  root 'encounters#index'

  # update party_stats for encounter new/edit
  get '(/encounters)/party_stats/(:id)', to: 'encounters#party_stats'
  get '/encounters/(:id/)party_stats/:id', to: 'encounters#party_stats'

  # update encounter_stats for encounter new/edit
  get '(/encounters)/encounter_stats/(:party_id)/(:fates_attributes)', to: 'encounters#encounter_stats'
  get '/encounters/(:id/)encounter_stats/(:party_id)/(:fates_attributes)', to: 'encounters#encounter_stats'

  # search monster using D&D 5e API
  get '/search', to: 'monsters#search'

  resources :monsters
  resources :encounters
  resources :parties

  # search monsters
  resources :monsters_search, only: [:index]
end
