class Category < ApplicationRecord
    before_action :authenticate_user!
    has_many :book_categories
    has_many :books, through: :book_categories
  end
  