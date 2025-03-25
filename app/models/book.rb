class Book < ApplicationRecord
    before_action :authenticate_user!
    belongs_to :user
    has_many :book_categories
    has_many :categories, through: :book_categories
  end
  