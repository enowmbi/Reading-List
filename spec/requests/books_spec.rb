require 'rails_helper'

RSpec.describe  Book,  type: :request do 
  before(:all) do 
    Book.create!([{title: "The Pragmatic Programmer",rating: 5},{title: "Enger's Game",rating: 4}])
  end

  after(:all) do 
    Book.destroy_all
  end

  describe  "GET /books" do 
    it "displays all books" do 
      get '/books'
      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq(Mime[:json])
      expect(JSON.parse(response.body).size).to eq(Book.count)
    end
  end

  it "displays books filtered by rating" do 
    get '/books?rating=5'
    expect(response).to have_http_status(:success)
    expect(response.content_type).to eq("application/json")
    expect(JSON.parse(response.body).size).to eq(1)
  end
end
