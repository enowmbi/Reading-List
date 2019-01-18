class Book < ApplicationRecord
  belongs_to :genre


  validates :title,presence: true


  scope :finished, -> {where('finished_at IS NOT NULL')}
end
