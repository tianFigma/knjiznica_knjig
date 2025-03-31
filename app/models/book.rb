class Book < ApplicationRecord
    belongs_to :user
    has_many :book_categories, dependent: :destroy
    has_many :categories, through: :book_categories
    # app/models/book.rb

    has_one_attached :image # This adds the image upload field

    validate :acceptable_image

    private

  def acceptable_image
    return unless image.attached?

    # Check the file content type (image/jpeg, image/png, image/gif)
    unless image.content_type.in?(%w[image/jpeg image/png image/gif])
      errors.add(:image, 'must be a JPEG, PNG, or GIF')
    end

    # Check if the file size exceeds 5 MB
    if image.byte_size > 5.megabytes
      errors.add(:image, 'is too big. Maximum size is 5MB')
    end
  end
end
  