class Bookmark < ApplicationRecord
  validates :user, uniqueness: { scope: :recipe }

  belongs_to :user
  belongs_to :recipe
end
