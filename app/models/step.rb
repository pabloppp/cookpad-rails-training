class Step < ApplicationRecord
  belongs_to :recipe

  has_attached_file :image,
                    styles: { medium: "400x300>", thumb: "133x100>" },
                    default_url: ""
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
