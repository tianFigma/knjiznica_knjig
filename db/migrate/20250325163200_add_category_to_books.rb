class AddCategoryToBooks < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :category, foreign_key: true, null: true
  end
end
