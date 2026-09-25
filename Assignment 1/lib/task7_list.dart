void listExample() {
  List<String> books = ['The Alchemist', 'Atomic Habits', 'Harry Potter'];

  print('Books in the list:');

  for (String book in books) {
    print(book);
  }

  books.add('The Hobbit');

  print('After adding a book:');
  print(books);
}
