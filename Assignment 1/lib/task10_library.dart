class LibraryBook {
  int id;
  String title;
  String author;
  bool isBorrowed;

  LibraryBook(this.id, this.title, this.author, {this.isBorrowed = false});

  void displayBook() {
    print(
      '$id - $title by $author - '
      '${isBorrowed ? "Borrowed" : "Available"}',
    );
  }
}

class LibraryMember {
  int id;
  String name;

  LibraryMember(this.id, this.name);

  void displayMember() {
    print('$id - $name');
  }
}

// Inheritance
class PremiumLibraryMember extends LibraryMember {
  PremiumLibraryMember(int id, String name) : super(id, name);

  void showPremiumStatus() {
    print('$name is a Premium Member.');
  }
}

class Library {
  List<LibraryBook> books = [];
  List<LibraryMember> members = [];

  Map<int, int> borrowedBooks = {};
  Set<String> memberNames = {};

  void addBook(LibraryBook book) {
    books.add(book);
    print('Book added successfully.');
  }

  void addMember(LibraryMember member) {
    members.add(member);
    memberNames.add(member.name);
    print('Member added successfully.');
  }

  void displayBooks() {
    print('\n--- Books ---');

    for (LibraryBook book in books) {
      book.displayBook();
    }
  }

  void displayMembers() {
    print('\n--- Members ---');

    for (LibraryMember member in members) {
      member.displayMember();
    }
  }

  void searchBook(String title) {
    bool found = false;

    for (LibraryBook book in books) {
      if (book.title.toLowerCase() == title.toLowerCase()) {
        book.displayBook();
        found = true;
      }
    }

    if (!found) {
      print('Book not found.');
    }
  }

  void borrowBook(int bookId, int memberId) {
    for (LibraryBook book in books) {
      if (book.id == bookId) {
        if (book.isBorrowed) {
          print('Book is already borrowed.');
          return;
        }

        book.isBorrowed = true;
        borrowedBooks[bookId] = memberId;

        print('Book borrowed successfully.');
        return;
      }
    }

    print('Book not found.');
  }

  void returnBook(int bookId) {
    for (LibraryBook book in books) {
      if (book.id == bookId) {
        if (!book.isBorrowed) {
          print('Book is already available.');
          return;
        }

        book.isBorrowed = false;
        borrowedBooks.remove(bookId);

        print('Book returned successfully.');
        return;
      }
    }

    print('Book not found.');
  }
}

void libraryDemo() {
  Library library = Library();

  library.addBook(LibraryBook(1, 'The Alchemist', 'Paulo Coelho'));

  library.addBook(LibraryBook(2, 'Atomic Habits', 'James Clear'));

  library.addBook(LibraryBook(3, 'Harry Potter', 'J.K. Rowling'));

  library.addMember(LibraryMember(101, 'Rahul'));

  library.addMember(PremiumLibraryMember(102, 'Aman'));

  print('\n===== LIBRARY SYSTEM =====');

  library.displayBooks();

  library.displayMembers();

  print('\nSearching for Atomic Habits:');
  library.searchBook('Atomic Habits');

  print('\nBorrowing book 1:');
  library.borrowBook(1, 101);

  library.displayBooks();

  print('\nReturning book 1:');
  library.returnBook(1);

  library.displayBooks();
}
