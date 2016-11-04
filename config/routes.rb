Rails.application.routes.draw do
  root 'home#show'
  get '/stats', to: 'stats#index'
end
