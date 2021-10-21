# frozen_string_literal: true

module Api
  module V1
    # Genre controller
    class GenresController < ApplicationController
      before_action :set_genre, only: %i[show update destroy]

      def index
        genres = Genre.all
        render(json: genres)
      end

      def show
        render(json: @genre, include: ['books'])
      end

      def create
        genre = Genre.new(genre_params)
        if genre.save
          render(json: genre, status: :created)
        else
          render(json: genre.errors, status: :unprocessable_entity)
        end
      end

      def update
        if @genre.update(genre_params)
          render(json: @genre)
        else
          render(json: @genre.errors, status: :unprocessable_entity)
        end
      end

      def destroy
        render(json: @genre.errors, status: :unprocessable_entity) unless @genre.destroy
      end

      private

      def set_genre
        @genre = Genre.find(params[:id])
      end

      def genre_params
        params.require(:genre).permit(:name)
      end
    end
  end
end

