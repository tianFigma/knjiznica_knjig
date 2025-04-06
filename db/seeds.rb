puts "🌱 Seeding database..."

# Clear old data if needed (optional)
BookCategory.destroy_all
Book.destroy_all
Category.destroy_all
User.destroy_all

puts "✅ Creating demo user..."
user = User.create!(
  email: "demo@example.com",
  password: "password",
  password_confirmation: "password"
)

puts "✅ Creating categories..."
fiction = Category.create!(name: "Fiction")
history = Category.create!(name: "History")

puts "✅ Creating books..."
book1 = Book.create!(
  title: "1984",
  author: "George Orwell",
  description: "Dystopian classic.",
  user: user
)

book2 = Book.create!(
  title: "Sapiens",
  author: "Yuval Noah Harari",
  description: "A brief history of humankind.",
  user: user
)

puts "✅ Linking books to categories..."
book1.categories << fiction
book2.categories << history

puts "✅ Seeding complete!"
