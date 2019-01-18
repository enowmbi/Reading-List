require 'rails_helper'

RSpec.describe Genre, type: :request  do 
  before(:all){Genre.create([{name: "Programming"},{name: "Strategy"}])}
  after(:all){Genre.destroy_all}

  describe 'GET /genres' do 

    describe 'returns collection of genres' do
      before(:all){ get '/genres'}

      it 'returns http status of success' do 
        expect(response).to have_http_status(:success)
      end

      it 'returns collection of genres as json' do 
        expect(response.content_type).to eq('application/json')
      end

      it 'returns the expected number of books' do 
        expect(JSON.parse(response.body).size).to eq(Genre.all.count)
      end
    end

    describe 'returns a selected genre based on id' do 
      before(:all){get "/genres/#{Genre.last.id}"}

      it 'returns http status of success' do 
        expect(response).to have_http_status(:success)
      end

      it 'returns selected genre as json' do 
        expect(response.content_type).to eq('application/json')
      end

      it 'returns selected genre' do 
        expect(JSON.parse(response.body)["name"]).to eq('Strategy')
      end
    end
  end

  describe 'POST /genres' do 
    let(:valid_params){{ genre: {name: "Fiction"}}}

    describe 'with valid params' do 
      before(:each){post genres_path,params: valid_params}

      it 'returns http status of created' do 
        expect(response).to have_http_status(:created)
      end

      it 'returns the created genre in json' do 
        expect(response.content_type).to eq('application/json')
      end

      it 'created the genre with the given parameters' do 
        expect(JSON.parse(response.body)["name"]).to eq('Fiction') 
      end
    end
  end

  describe 'PATCH /genre/id' do 

    let(:my_genre){Genre.first}
    let(:valid_params){{genre: {name: "Non-Fiction"}}}
    before(:each){patch genre_url(my_genre,params: valid_params)}

    it 'returns http status of success' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the updated genre in json' do 
      expect(response.content_type).to eq('application/json')
    end

    it 'updated the selected genre' do 
      expect(JSON.parse(response.body)["name"]).to eq('Non-Fiction')
    end
  end

  describe 'DELETE /genre/id' do 
    let(:my_genre){Genre.last}

    it 'returns http status of no_content' do 
      delete  genre_url(my_genre)
      expect(response).to have_http_status(:no_content)
    end
  end

end 
