class BookSerializer < ActiveModel::Serializer
  attributes :id,:title,:rating,:finished_at, :genre

  belongs_to :genre
end
