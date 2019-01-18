Rails.application.routes.draw do
  resources "books", only: [:index, :create, :show, :update, :destroy]
  get 'books/finished'
  resources "genres", only: [:index, :show, :create, :update, :destroy]
end
