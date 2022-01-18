Rails.application.routes.draw do
  resources :monsters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('encounter-builder/')
  get 'encounter-builder', to: 'encounter_builder#index'

  post '/player', to: 'encounter_builder#add_player', as: 'encounter_builder_player'
  delete '/player/:id', to: 'encounter_builder#delete_player'

  post '/monster', to: 'encounter_builder#add_monster', as: 'encounter_builder_monster'
  delete '/monster/:id', to: 'encounter_builder#delete_monster'

  post '/create', to: 'encounter_builder#create', as: 'encounter_builder_create'


  get '/reset', to: 'encounter_builder#reset'
end
