require 'rails_helper'

RSpec.describe  Book,  type: :request do 

  before(:all) do 
    Book.create!([{title: "The Pragmatic Programmer",rating: 5,finished_at: 1.day.ago},{title: "Enger's Game",rating: 4,finished_at: nil}])
  end

  after(:all) do 
    Book.destroy_all
  end

  describe  'GET /books' do 
    before(:all){ get '/books' }

    it 'returns http status of success' do 
      expect(response).to have_http_status(:success)
    end

    it "returns content_type of json" do 
      expect(response.content_type).to eq(Mime[:json])
    end

    it "returns the expected number of books" do 
      expect(JSON.parse(response.body).size).to eq(Book.count)
    end
  end

  describe 'GET /books?rating=5 (filter by rating)' do 
    before(:all){ get '/books?rating=5'}

    it 'returns http status of success' do 
      expect(response).to have_http_status(:success)
    end 

    it 'returns content_type of json' do 
      expect(response.content_type).to eq('application/json')
    end

    it 'returns the expected number of books' do
      expect(JSON.parse(response.body).size).to eq(1)
    end

  end 

  describe 'GET /books/finished' do 
    before(:all){get '/books/finished'}

    it 'returns http status of success' do 
      expect(response).to have_http_status(:success)
    end 

    it 'returns content_type of json' do 
      expect(response.content_type).to eq('application/json')
    end

    it 'returns the expected number of books' do
      expect(JSON.parse(response.body).size).to eq(1)
    end
  end

end
