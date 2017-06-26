class UserActivity < ApplicationRecord
  belongs_to :user
  belongs_to :target, polymorphic: true

  delegate :username, to: :user

  has_many :feed_items, dependent: :destroy
end
