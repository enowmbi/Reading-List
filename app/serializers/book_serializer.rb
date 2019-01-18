class BookSerializer < ActiveModel::Serializer
  attributes :id,:title,:rating,:finished_at, :genre_id

  belongs_to :genre
end
