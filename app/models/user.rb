class User < ApplicationRecord
  has_one_attached :avatar
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :login, presence: true, uniqueness: true
  validates :password, length: { minimum: 3}, :if => :password
end
