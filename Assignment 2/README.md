# Async Dart Delivery Project

## Project Overview

This project demonstrates how to use Dart asynchronous programming concepts with a simple delivery example. The program simulates fetching delivery information from a mock API and then displays the result.

The main concepts used are:

- Null Safety
- Future
- async / await
- Try / Catch / Finally
- Mock API data
- Error handling
- Nullable variables

## Files

### `async_dart_desi.dart`

Contains the delivery logic, mock API function, null checks, and error handling.

### `main.dart`

Contains the `main()` function and calls `deliveryCheck()` using `await`.

## How It Works

1. `main()` starts the program.
2. `deliveryCheck()` starts the delivery process.
3. `delivery()` returns a `Future` containing mock API data.
4. `await` waits for the asynchronous result.
5. The program checks whether the API response is `null`.
6. It also checks whether important fields are missing.
7. If the person matches, the delivery status is displayed.
8. `catch` handles unexpected errors.
9. `finally` runs at the end of the process.

## Run the Project

Make sure Dart SDK is installed.

Run:

```bash
dart run main.dart
```

Expected output:

```text
Delivery Process Started
Delivery Will be Done Soon
Delivery Will be Done Soon
Delivery done
Delivery Process Finished
```

## Important Dart Concepts

### Future

A `Future` represents a value that will be available later.

```dart
Future<Map<String, String>?> delivery() async
```

### async

The `async` keyword allows a function to perform asynchronous operations.

### await

The `await` keyword waits for a Future to complete without blocking the rest of the application.

### Null Safety

The `?` means that a value is allowed to be null.

```dart
Future<Map<String, String>?> delivery()
```

The program checks for null before using the data.

### Try / Catch / Finally

`try` contains code that may produce an error, `catch` handles the error, and `finally` runs whether an error occurs or not.

## Project Learning Outcome

This project helped demonstrate how asynchronous API-style operations can be handled safely in Dart. It combines Future, async/await, null safety, mock data, and error handling in one practical example.
