class List < ApplicationRecord
  validates :name, uniqueness: true, presence: true

  has_one_attached :photo
  has_many :bookmarks, dependent: :destroy
  has_many :movies, through: :bookmarks
end
