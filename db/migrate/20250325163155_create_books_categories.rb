class CreateBooksCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :books_categories do |t|
      t.timestamps
    end
  end
end
