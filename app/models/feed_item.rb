class FeedItem < ApplicationRecord
  validates :user, uniqueness: { scope: :user_activity }

  belongs_to :user
  belongs_to :user_activity

  def author_name
    user_activity.username
  end
end
