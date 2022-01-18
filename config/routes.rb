Rails.application.routes.draw do
  resources :monsters
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'build#index'

  post '/build/player', to: 'build#add_player'
  delete '/build/player/:id', to: 'build#delete_player'

  post '/build/monster', to: 'build#add_monster'
  delete '/build/monster/:id', to: 'build#delete_monster'

  post '/build/create', to: 'build#create'


  get '/build/reset', to: 'build#reset'
end
