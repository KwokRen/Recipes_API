class User < ApplicationRecord
  validates_presence_of :username, :password_digest
  has_secure_password
  has_many :categories, dependent: :destroy
  has_many :recipes, through: :categories
end
