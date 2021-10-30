class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true

  has_one_attached :image
end
