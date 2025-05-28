Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  
  use_doorkeeper
  devise_for :users
  # resources :leagues, only: [:index, :show, :create, :update, :destroy]
  # resources :matches, only: [:index, :show, :create, :update, :destroy]
  # resources :players, only: [:index, :show, :create, :update, :destroy]
  # resources :teams, only: [:index, :show, :create, :update, :destroy]

  draw :api

end
