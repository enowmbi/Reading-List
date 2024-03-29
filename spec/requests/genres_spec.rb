# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Genre, type: :request do
  before(:all) { Genre.create([{ name: 'Programming' }, { name: 'Fiction' }]) }
  after(:all) { Genre.destroy_all }

  describe 'GET /api/v1/genres' do
    describe 'returns collection of genres' do
      before(:all) { get '/api/v1/genres' }

      it 'returns http status of success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns collection of genres as json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns the expected number of books' do
        expect(JSON.parse(response.body).size).to eq(Genre.all.count)
      end
    end

    describe 'returns a selected genre based on id' do
      before(:all) { get "/api/v1/genres/#{Genre.last.id}" }

      it 'returns http status of success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns selected genre as json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'returns selected genre' do
        expect(JSON.parse(response.body)['name']).to eq('Fiction')
      end
    end
  end

  describe 'POST /api/v1/genres' do
    let(:valid_params) { { genre: { name: 'Fiction' } } }

    describe 'with valid params' do
      before(:each) { post api_v1_genres_path, params: valid_params }

      it 'returns http status of created' do
        expect(response).to have_http_status(:created)
      end

      it 'returns the created genre in json' do
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end

      it 'created the genre with the given parameters' do
        expect(JSON.parse(response.body)['name']).to eq('Fiction')
      end
    end
  end

  xdescribe 'PATCH /api/v1/genre/id' do
    let(:my_genre) { Genre.first }
    let(:valid_params) { { genre: { name: 'Non-Fiction' } } }
    before(:each) { patch api_v1_genre_url(my_genre, params: valid_params) }

    it 'returns http status of success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated genre in json' do
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end

    it 'updated the selected genre' do
      expect(JSON.parse(response.body)['name']).to eq('Non-Fiction')
    end
  end

  describe 'DELETE /api/v1/genre/id' do
    let(:my_genre) { Genre.last }

    before(:each) do
      my_genre.books.create(
        [
          {
            title: 'War Room',
            rating: 5,
            finished_at: 2.years.ago
          },
          {
            title: "The Devil's advocate",
            rating: 2,
            finished_at: 17.years.ago
          },
          {
            title: 'Suits',
            rating: 4.5,
            finished_at: 3.months.ago
          },
          {
            title: 'Desperate Housewives',
            rating: 4,
            finished_at: 5.years.ago
          }
        ]
      )
      delete api_v1_genre_url(my_genre)
    end

    it 'returns http status of no_content' do
      expect(response).to have_http_status(:no_content)
    end

    it 'returns book(children) count of zero' do
      expect(my_genre.books.count).to eq(0)
    end
  end
end
