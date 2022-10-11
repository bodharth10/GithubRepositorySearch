Rails.application.routes.draw do
  root 'static#home'
  get '/search', to: 'static#search'
end
