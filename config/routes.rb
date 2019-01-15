Rails.application.routes.draw do
  resources "books", only: [:index]
  get 'books/finished'
end
