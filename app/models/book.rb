class Book < ApplicationRecord
  validates :title,presence: true


  scope :finished, -> {where('finished_at IS NOT NULL')}
end
