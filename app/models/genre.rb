# frozen_string_literal: true

# Genre model
class Genre < ApplicationRecord
  has_many :books, dependent: :destroy

  validates :name, presence: true
end
