import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _userId;

  bool get isAuth {
    return _token != null;
  }

  String? get userId {
    return _userId;
  }

  Future<void> login(String email, String password) async {
    // Implement your login logic here
    // For example, send a request to your server and get the token
    // Simulating a network request
    await Future.delayed(Duration(seconds: 2));

    if (email == 'test@test.com' && password == 'password') {
      _token = 'dummy_token';
      _userId = 'dummy_user_id';
    } else {
      throw Exception('Failed to login');
    }
    notifyListeners();
  }

  Future<void> register(String email, String password) async {
    // Implement your register logic here
    // Simulating a network request
    await Future.delayed(Duration(seconds: 2));
    // Assuming registration is always successful
    _token = 'dummy_token';
    _userId = 'dummy_user_id';
    notifyListeners();
  }

  void logout() {
    _token = null;
    _userId = null;
    notifyListeners();
  }
}
