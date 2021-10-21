# frozen_string_literal: true

module Api
  module V1
    # Book controller
    class BooksController < ApplicationController
      before_action :set_book, only: %i[show update destroy]

      def index
        books = if rating == params[:rating]
                  Book.where(rating: rating)
                else
                  Book.all
                end

        render(json: books, status: :ok)
      end

      def finished
        books = Book.finished
        render(json: books)
      end

      def show
        render(json: @book)
      end

      def create
        book = Book.new(book_params)
        if book.save
          render(json: book, status: :created)
        else
          render(json: book.errors, status: :unprocessable_entity)
        end
      end

      def update
        render(json: @book.errors, status: :unprocessable_entity) unless @book.update(book_params)
      end

      def destroy
        render(json: @book.errors, status: :unprocessable_entity) unless @book.destroy
      end

      private

      def set_book
        @book = Book.find(params[:id])
      end

      def book_params
        params.require(:book).permit(:title, :rating, :finished_at, :genre_id)
      end
    end
  end
end
