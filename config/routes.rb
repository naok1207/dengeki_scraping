Rails.application.routes.draw do
  resources :books, only: %i[index show]
  get '/search', to: 'books#search', as: 'search'
  get '/books/series/:id', to: 'books#series', as: 'series'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
