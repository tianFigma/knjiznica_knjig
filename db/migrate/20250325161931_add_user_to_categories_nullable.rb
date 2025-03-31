class AddUserToCategoriesNullable < ActiveRecord::Migration[8.0]
  def change
    add_reference :categories, :user, foreign_key: true, null: true
  end
end
