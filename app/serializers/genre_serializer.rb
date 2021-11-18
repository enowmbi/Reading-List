# frozen_string_literal: true

# genre serializer
class GenreSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :books
end
