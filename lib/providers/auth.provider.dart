import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/auth.api.dart';
import '../classes/user.model.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _account;
  String? _token;

  UserModel? get user => _account;
  String? get token => _token;

  // Login function
  Future<void> login(String email, String password) async {
    final data = await AuthAPI.login(email, password);
    if (data != null) {
      _token = data['token']; // Set the token
      _account = UserModel.fromJson(data['account']); // Set the account details
      await _saveToken(_token!);
      notifyListeners(); // Notify listeners about changes

      Fluttertoast.showToast(
          msg: "Login Successful", backgroundColor: Colors.green);

      return;
    }

    Fluttertoast.showToast(msg: "Login Failed", backgroundColor: Colors.red);
  }

  // Register function
  Future<void> register(
      String userName, String password, String referrerCode) async {
    final data = await AuthAPI.register(userName, password, referrerCode);
    if (data != null) {
      _token = data['token'];
      _account = UserModel.fromJson(data['account']);
      await _saveToken(_token!);

      notifyListeners();

      Fluttertoast.showToast(
          msg: "Registration Successful", backgroundColor: Colors.green);

      return;
    }

    Fluttertoast.showToast(
        msg: "Registration Failed", backgroundColor: Colors.red);
  }

  // Logout function
  Future<void> logout() async {
    _account = null;
    _token = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    notifyListeners();

    Fluttertoast.showToast(
        msg: "Logout Successful", backgroundColor: Colors.green);
  }

  // Save the token locally
  Future<void> _saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('authToken', token);
  }

  // Load the token when the app starts
  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('authToken');
    if (_token != null) {
      final userData = await AuthAPI.getMe(_token!);
      if (userData != null) {
        _account = UserModel.fromJson(userData['account']);
        notifyListeners();
      }
    }
  }
}
