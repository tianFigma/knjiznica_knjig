class Book < ApplicationRecord
    belongs_to :user
    has_many :book_categories
    has_many :categories, through: :book_categories
    # app/models/book.rb

    has_one_attached :image # This adds the image upload field


  end
  