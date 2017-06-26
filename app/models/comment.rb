class Comment < ApplicationRecord
  validates :body, presence: true

  belongs_to :user
  belongs_to :recipe, counter_cache: true

  delegate :username, to: :user
end
