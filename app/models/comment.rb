class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy

  validates :body, presence: true,
                   length: { minimum: 5 }

  self.per_page = 5

  def article_commentable_type?
    false
  end
end
