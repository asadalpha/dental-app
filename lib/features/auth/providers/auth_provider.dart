import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Simulating a login API call
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Mock network delay
    await Future.delayed(const Duration(seconds: 2));

    _isLoading = false;
    notifyListeners();

    // Always returning true for this demo
    return true;
  }

  // Simulating a logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    // Mock network/clear delay
    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    notifyListeners();
  }
}
