Rails.application.routes.draw do
  root 'home#index'
  get '/stats', to: 'stats#index'
  get '/learn', to: 'posts#index'
  get '/learn/:id', to: 'posts#show'
  get '/predictions', to: 'predictions#index'
end
