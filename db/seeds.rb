# Create a dummy user
user = User.create!(
  email: "demo@example.com",
  password: "password",
  password_confirmation: "password"
)

# Now assign that user to the categories
category1 = Category.create!(name: "Fiction", user: user)
category2 = Category.create!(name: "Non-Fiction", user: user)

# Create books (no user required here unless you have a constraint)
book1 = Book.create!(title: "Book One", author: "Author One", description: "Description of Book One")
book2 = Book.create!(title: "Book Two", author: "Author Two", description: "Description of Book Two")

# Assign categories to books
book1.categories << category1
book2.categories << category2
book1.categories << category2
