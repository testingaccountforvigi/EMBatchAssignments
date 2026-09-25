void mapExample() {
  Map<int, String> students = {1: 'Rahul', 2: 'Aman', 3: 'Riya'};

  print('Student Map:');

  students.forEach((id, name) {
    print('$id : $name');
  });

  students[4] = 'Neha';

  print('After adding a student:');
  print(students);
}
