# Dart Console Library System

A simple **Dart console program** that models a library system using variables, loops, functions, and Object-Oriented Programming (OOP) with inheritance.

## Assignment Requirement

> Write a Dart console program that uses variables, loops, functions, and OOP (class with inheritance) to model a simple library system.

## Features

- Add books and members
- Display books and members
- Search for a book
- Borrow and return books
- Track borrowed books
- Demonstrate inheritance with `PremiumLibraryMember`

## Concepts Used

- Classes and objects
- Constructors
- Methods
- Inheritance
- `List`
- `Map`
- `Set`
- Variables
- Functions
- Loops
- Conditional statements

## Main Classes

### `LibraryBook`

Stores the book ID, title, author, and borrowed/available status.

### `LibraryMember`

Stores the member ID and name.

### `PremiumLibraryMember`

Extends `LibraryMember` and demonstrates inheritance.

### `Library`

Manages books, members, borrowing, returning, and searching.

## Running the Program

From the project root:

```bash
dart run lib/task10_library.dart
```

## Program Flow

1. Books are added.
2. Members are registered.
3. Books and members are displayed.
4. A book is searched by title.
5. A book is borrowed.
6. Its status changes to `Borrowed`.
7. The book is returned.
8. Its status changes back to `Available`.

## Screenshots

- In PDF

## What I Learned

The main thing I learned from this assignment is that **classes give different parts of a program their own responsibility**. Instead of putting everything into one large function, books, members, and the library can each have their own data and behavior.

I also understood inheritance more clearly by creating `PremiumLibraryMember` from `LibraryMember`. It showed me how a class can reuse existing functionality while adding something of its own.

Using `List`, `Map`, and `Set` in the same project helped me understand why different collection types are useful for different kinds of data.

## Author

**Mahesh Rajpurohit**

B.Tech Computer Science Engineering
