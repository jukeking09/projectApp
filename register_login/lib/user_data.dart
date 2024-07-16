import 'package:flutter/material.dart';

class UserData with ChangeNotifier {
  int? userId;

  void setUserId(int newUserId) {
    userId = newUserId;
    notifyListeners(); // Notify listeners about the change
  }
}