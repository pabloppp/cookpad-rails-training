class SearchIndex < ApplicationRecord
  validates :recipe, uniqueness: true, presence: true
  validates :index, presence: true
  belongs_to :recipe
end
