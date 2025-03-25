class AddUserToBooksNullable < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :user, foreign_key: true, null: true
  end
end
