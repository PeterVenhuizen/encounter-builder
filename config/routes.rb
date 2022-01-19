Rails.application.routes.draw do
  resources :monsters
  resources :encounters

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: redirect('encounters/new')

  # Add / Delete player
  post '/player', to: 'encounters#add_player', as: 'encounters_player'
  delete '/player/:id', to: 'encounters#delete_player'

  # Add / Delete monster
  post '/monster', to: 'encounters#add_monster', as: 'encounters_monster'
  delete '/monster/:id', to: 'encounters#delete_monster'

  get '/reset', to: 'encounters#reset'
end
