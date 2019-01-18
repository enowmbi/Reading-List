class Genre < ApplicationRecord
has_many :books, dependent: :destroy

validates :name,presence: true
end
