class RemoveCategoryIdFromBooks < ActiveRecord::Migration[8.0]
  def change
    remove_column :books, :category_id, :integer
  end
end
