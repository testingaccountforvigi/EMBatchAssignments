mixin Printable {
  void printMessage() {
    print('This message comes from a mixin.');
  }
}

class Report with Printable {
  void showReport() {
    print('Library Report');
    printMessage();
  }
}
