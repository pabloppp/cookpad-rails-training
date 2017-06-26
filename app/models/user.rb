class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :username, presence: true, uniqueness: true

  has_many :recipes, dependent: :destroy

  has_many :followed_user_relationships,
           foreign_key: :follower_id,
           class_name: "Follow",
           dependent: :destroy,
           counter_cache: :followed_users_count
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
           foreign_key: :followed_user_id,
           class_name: "Follow",
           dependent: :destroy,
           counter_cache: :followers_count
  has_many :followers, through: :follower_relationships

  has_many :likes, dependent: :destroy
  has_many :liked_recipes,
           through: :likes, source: :recipe

  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_recipes,
           through: :bookmarks, source: :recipe

  has_many :comments, dependent: :destroy

  has_many :feed_items, dependent: :destroy

  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "100x100>" },
                    default_url: ""
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  def owns?(object)
    object.user_id == id
  end

  def follow(user)
    followed_users << user
  end

  def unfollow(user)
    followed_users.delete(user)
  end

  def follows?(user)
    followed_users.include?(user)
  end

  def like(recipe)
    likes.find_or_create_by(recipe: recipe)
  rescue ActriveRecord::RecordNotUnique
    retry
  end

  def unlike(recipe)
    liked_recipes.delete(recipe)
  end

  def likes?(recipe)
    liked_recipes.include?(recipe)
  end

  def bookmark(recipe)
    bookmarks.find_or_create_by(recipe: recipe)
  rescue ActriveRecord::RecordNotUnique
    retry
  end

  def unbookmark(recipe)
    bookmarked_recipes.delete(recipe)
  end

  def bookmarked?(recipe)
    bookmarked_recipes.include?(recipe)
  end
end
