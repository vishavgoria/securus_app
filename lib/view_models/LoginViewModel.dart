
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test1/model/AuthResponseModel.dart';
import 'package:test1/rest/api_constants.dart';

class LoginViewModel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  AuthResponseModel authResponseModel = AuthResponseModel.empty();
  late String authorization;


  Future<void> authenticateUser(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> requestBody = {
      'user': email,
      'password': password,
    };

    try {
      final http.Response response = await http.post(
        Uri.parse('$BASE_URL$LOGIN_URL'),
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful authentication
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        authResponseModel = AuthResponseModel.fromJson(responseData);
        authorization = response.headers['authorization']!;
      } else {
        // Authentication failed
        print('Authentication failed. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error while authenticating: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  logout(){
    //Handle Logout logic, (which is not part of the exercise and no api given to call logout)
  }
}

