Rails.application.routes.draw do
  get '/clients/:id/events', to: 'clients#list'
  post '/client/:id/events', to: 'clients#new'
  post '/clients/:id/events/:event_id/publish', to: 'clients#publish'
  get '/events', to: 'events#list'
  get '/events/:id', to: 'events#view'
  post '/event/:id/buy', to: 'events#buy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
