class Like < ApplicationRecord
  validates :user, uniqueness: { scope: :recipe }

  belongs_to :user
  belongs_to :recipe, counter_cache: true
end
