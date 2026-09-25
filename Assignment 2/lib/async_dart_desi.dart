// Future & ASYNC/AWAIT
// Null Safety
// Try, Catch, Finally

String personName = "Mahesh";

// Mock API data
Future<Map<String, String>?> delivery() async {
  print("Delivery Will be Done Soon");

  await Future.delayed(Duration(seconds: 2));

  // Simulating mock API response
  return {"person": "Mahesh", "status": "Delivery done"};
}

Future<void> deliveryCheck() async {
  try {
    print("Delivery Process Started");

    // Future + async/await
    final Map<String, String>? data = await delivery();

    // Null Safety
    if (data == null) {
      print("No delivery data found");
      return;
    }

    // Null-aware access
    final String? deliveryPerson = data["person"];
    final String? status = data["status"];

    if (deliveryPerson == null || status == null) {
      print("Incomplete delivery data");
      return;
    }

    if (personName != deliveryPerson) {
      print("Wrong Person");
    } else {
      print("Delivery Will be Done Soon");

      await Future.delayed(Duration(seconds: 2));

      print(status);
    }
  } catch (error) {
    // Error Handling
    print("Something went wrong: $error");
  } finally {
    // Finally
    print("Delivery Process Finished");
  }
}
