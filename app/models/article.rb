class Article < ApplicationRecord
    belongs_to :user
    has_many :articles_categories
    has_many :categories, through: :articles_categories
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 10000 }
    has_attached_file :image
    has_many :comments
end