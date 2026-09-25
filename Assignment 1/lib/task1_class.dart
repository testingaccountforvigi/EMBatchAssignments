class Book {
  String title;
  String author;

  Book(this.title, this.author);

  void display() {
    print('Book: $title');
    print('Author: $author');
  }
}
