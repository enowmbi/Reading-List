Rails.application.routes.draw do
  namespace :api do 
    namespace :v1 do 
      root 'books#index'
      resources "books", only: [:index, :create, :show, :update, :destroy]
      get 'books/finished'
      resources "genres", only: [:index, :show, :create, :update, :destroy]
    end
  end
end
