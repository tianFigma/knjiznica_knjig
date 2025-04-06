# db/seeds.rb

puts "🌱 Seeding database..."

# Create a user
puts "✅ Creating demo user..."
user = User.create!(
  email: "demo@example.com",
  password: "password",
  password_confirmation: "password"
)

# Create categories assigned to the user
puts "✅ Creating categories..."
category1 = Category.create!(name: "Fiction", user: user)
category2 = Category.create!(name: "Non-Fiction", user: user)

# Create books
puts "✅ Creating books..."
book1 = Book.create!(
  title: "Book One",
  author: "Author One",
  description: "Description of Book One"
)

book2 = Book.create!(
  title: "Book Two",
  author: "Author Two",
  description: "Description of Book Two"
)

# Associate books with categories
puts "✅ Linking books to categories..."
book1.categories << category1
book2.categories << category2
book1.categories << category2

puts "✅ Done seeding!"
