class Category < ApplicationRecord
  has_many :book_categories, dependent: :destroy
    has_many :books, through: :book_categories
  end
  