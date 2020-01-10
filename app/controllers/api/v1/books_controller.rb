module Api
  module V1
    class BooksController < ApplicationController
      before_action :set_book, only: [:show, :update, :destroy]

      def index 
        if rating = params[:rating]
          books = Book.where(rating: rating)
        else
          books = Book.all
        end

        render json: books, status: :ok 
      end

      def finished
        books = Book.finished
        render json: books
      end

      def show
        render json: @book 
      end

      def create
        book = Book.new(book_params)
        if book.save
          render json: book, status: :created
        else
          render json: book.errors, status: :unprocessable_entity
        end
      end

      def update
        if !@book.update(book_params)
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if !@book.destroy
          render json: @book.errors, status: :unprocessable_entity
        end
      end

      private
      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title,:rating,:finished_at,:genre_id)
      end
    end
  end
end
