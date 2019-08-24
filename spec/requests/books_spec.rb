require 'rails_helper'

RSpec.describe  Book,  type: :request do 

  before(:all) do 
    genre = Genre.create!(name: 'Programming')
    genre2 = Genre.create!(name: 'Fiction')

    genre.books.create!([{title: "The Pragmatic Programmer",rating: 5,finished_at: 1.day.ago},{title: "Enger's Game",rating: 4,finished_at: nil}])
    genre2.books.create!([{title: "The Dressmaker",rating: 3,finished_at: 41.day.ago},{title: "A Thousand Ways to die in the West",rating: 2,finished_at: 23.days.ago}])
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
      expect((JSON.parse(response.body)["data"]).size).to eq(Book.count)
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
    before(:all){get "/books?finished_at=#{1.day.ago}"}

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

  describe 'POST /books' 
  let(:my_genre){Genre.create(name: "Programming")}
  let(:valid_params) {{ book: {title: "Learning ruby the hard way", rating: 5 ,finished_at: 3.days.ago,genre_id: my_genre.id} } }

  describe 'using valid data' do 
    before(:each){post books_url, params: valid_params}

    it "returns http status of created" do
      expect(response).to have_http_status(:created)
    end

    it "returns created book as json" do 
      expect(response.content_type).to eq('application/json')
    end

    it "returns the last book created" do 
      expect((JSON.parse(response.body)["data"]["id"]).to_i).to eq(Book.last.id)
    end

    it "returns the books collection incremented by one" do 
      expect(Book.count).to eq(5) 
    end
  end

  describe 'GET /book/id' do 
    before(:all) do 
      @first_book = Book.first
      @first_genre = @first_book.genre
      get "/books/#{@first_book.id}"
    end

    it 'returns http status of success' do 
      expect(response).to have_http_status(:success)
    end

    it 'returns selected book as json' do 
      expect(response.content_type).to eq('application/json')
    end

    it 'returns only selected book' do 
      expect((JSON.parse(response.body)["data"]["id"]).to_i).to eq(@first_book.id)
    end

   it 'returns the genre of the selected book' do 
      expect((JSON.parse(response.body)["data"]["attributes"]["genre"]["id"]).to_i).to eq(@first_genre.id)
    end
  end

  describe 'PATCH /book/id' do 
    let(:my_book){Book.first}
    let(:valid_params) {{ book: {title: "Learning ruby the hard way 2", rating: 1 ,finished_at: 6.days.ago} } }

    before(:each){patch book_url(my_book, params: valid_params)}

    it 'returns http status of no_content' do 
      expect(response).to have_http_status(:no_content)

    end
  end

  describe 'DELETE /book/id' do 
    let(:my_book){Book.first}
    before(:each){delete book_url(my_book)} 

    it 'returns http status of no_content' do 
      expect(response).to have_http_status(:no_content)
    end


  end
end
