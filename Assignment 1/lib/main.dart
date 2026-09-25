import 'task1_class.dart';
import 'task2_constructor.dart';
import 'task3_methods.dart';
import 'task4_inheritance.dart';
import 'task5_mixin.dart';
import 'task6_interface.dart';
import 'task7_list.dart';
import 'task8_map.dart';
import 'task9_set.dart';
import 'task10_library.dart';

void main() {
  print('===== TASK 1: CLASS =====');

  Book book = Book('The Alchemist', 'Paulo Coelho');
  book.display();

  print('\n===== TASK 2: CONSTRUCTOR =====');

  Student student = Student('Mahesh', 19);
  student.display();

  print('\n===== TASK 3: METHODS =====');

  Calculator calculator = Calculator();
  print('Addition: ${calculator.add(10, 5)}');
  print('Subtraction: ${calculator.subtract(10, 5)}');
  print('Multiplication: ${calculator.multiply(10, 5)}');

  print('\n===== TASK 4: INHERITANCE =====');

  PremiumMember member = PremiumMember('Aman');
  member.showMember();
  member.showPremium();

  print('\n===== TASK 5: MIXIN =====');

  Report report = Report();
  report.showReport();

  print('\n===== TASK 6: INTERFACE =====');

  BookDetails details = BookDetails('Atomic Habits');
  details.printDetails();

  print('\n===== TASK 7: LIST =====');

  listExample();

  print('\n===== TASK 8: MAP =====');

  mapExample();

  print('\n===== TASK 9: SET =====');

  setExample();

  print('\n===== TASK 10: LIBRARY SYSTEM =====');

  libraryDemo();
}
