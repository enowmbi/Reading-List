
RSpec.describe Book, type: :model do
  let(:book){Book.new(title:"my title",rating:4,finished_at:1.day.ago)}
  context "validation" do 

    it "should fail without title" do 
      book.title = ""
      expect(book).not_to be_valid
    end

  
  end
end
