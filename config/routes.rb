Rails.application.routes.draw do
  root 'home#index'

  get '/auth/github', as: 'github_login'
  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'

  get '/stats', to: 'stats#index'
  get '/learn', to: 'posts#index'
  get '/learn/:id', to: 'posts#show'
  get '/predictions', to: 'predictions#index'
end
