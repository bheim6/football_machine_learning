Rails.application.routes.draw do
  root 'home#show'
  get '/stats', to: 'stats#index'
  get '/learn', to: 'posts#index'
  get '/learn/:id', to: 'posts#show'
end
