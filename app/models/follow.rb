class Follow < ApplicationRecord
  validate :ensure_not_following_self
  validates :follower_id, uniqueness: { scope: :followed_user_id }

  belongs_to :follower, class_name: "User", counter_cache: :followed_users_count
  belongs_to :followed_user, class_name: "User", counter_cache: :followers_count

  private

  def ensure_not_following_self
    return if follower_id != followed_user_id
    errors.add(:follower_id, "can not follow self")
  end
end
