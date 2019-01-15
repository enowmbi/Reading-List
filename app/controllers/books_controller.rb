class BooksController < ApplicationController

  def index 
    if rating = params[:rating]
      books = Book.where(rating: rating)
    else
      books = Book.all
    end

    render json: books 
  end

  def finished
    books = Book.finished
    render json: books
  end
end
