Rails.application.routes.draw do
  get '/', to: redirect('/api/v1/books')
  get '/books', to: redirect('/api/v1/books')
  get '/books/:id', to: redirect('/api/v1/books/#{id}')
  get '/genres', to: redirect('/api/v1/genres')
  get '/genres/:id', to: redirect('/api/v1/genres/#{id}')
  namespace :api do 
    namespace :v1 do 
      root 'books#index'
      resources "books", only: [:index, :create, :show, :update, :destroy]
      get 'books/finished'
      resources "genres", only: [:index, :show, :create, :update, :destroy]
    end
  end
end
