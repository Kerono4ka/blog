class Article < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  validates :title, presence: true,
                    length: { minimum: 5 }

  self.per_page = 10

end
