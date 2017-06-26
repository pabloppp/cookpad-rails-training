class Recipe < ApplicationRecord
  validates :title, presence: true
  validates :ingredients, length: { minimum: 1 }
  validates :steps, length: { minimum: 1 }

  belongs_to :user, counter_cache: true
  has_many :ingredients, dependent: :destroy, inverse_of: :recipe
  has_many :steps, dependent: :destroy, inverse_of: :recipe

  accepts_nested_attributes_for :ingredients, allow_destroy: true,
                                              reject_if: :all_blank
  accepts_nested_attributes_for :steps, allow_destroy: true,
                                        reject_if: :all_blank

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :user_activities, as: :target, dependent: :destroy

  has_one :search_index, dependent: :destroy

  has_attached_file :image,
                    styles: { medium: "400x300>", thumb: "133x100>" },
                    default_url: ""
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  delegate :username, to: :user

  scope :latest, -> { order(created_at: :desc) }
  scope :search, lambda { |query:|
    joins(:search_index)
      .where("`search_indices`.`index` LIKE ?", "%#{query}%")
  }
end
