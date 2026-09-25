abstract class Printable {
  void printDetails();
}

class BookDetails implements Printable {
  String title;

  BookDetails(this.title);

  @override
  void printDetails() {
    print('Book title: $title');
  }
}
