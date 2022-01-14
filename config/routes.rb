Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'build#index'
  get '/angry', to: 'build#index'
  post '/build/test', to: 'build#test', as: 'test'

  post '/build/player', to: 'build#player'
  post '/build/monster', to: 'build#monster'

  get '/build/reset', to: 'build#reset'
end
