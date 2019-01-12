require 'rails_helper'

feature 'listing books', type: :feature  do 
  it 'list all books' do 
    visit '/books'
    expect(page).to have_http_status(:success)
  end
end
