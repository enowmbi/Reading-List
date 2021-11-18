# frozen_string_literal: true

# book serializer class
class BookSerializer < ActiveModel::Serializer
  attributes :id, :title, :rating, :finished_at

  belongs_to :genre
end
