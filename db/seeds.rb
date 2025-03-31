category1 = Category.create(name: "Fiction")
category2 = Category.create(name: "Non-Fiction")

book1 = Book.create(title: "Book One", author: "Author One", description: "Description of Book One")
book2 = Book.create(title: "Book Two", author: "Author Two", description: "Description of Book Two")

book1.categories << category1
book2.categories << category2
book1.categories << category2
