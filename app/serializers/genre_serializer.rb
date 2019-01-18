class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :books
end
