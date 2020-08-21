class Category < ApplicationRecord
  has_many :recipes, dependent: :destroy

  validates_presence_of :title, :created_by
end
