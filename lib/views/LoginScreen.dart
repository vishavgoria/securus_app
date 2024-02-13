


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app_constants.dart';
import '../view_models/LoginViewModel.dart';



class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}


class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(loginTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Consumer<LoginViewModel>(
            builder: (context, loginViewModel, _) {
              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: userEmailLabel),
                      validator: (value) {
                        if (value == null || value.isEmpty || !isValidEmail(value)) {
                          return 'Please enter your valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(labelText: userPasswordLabel),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: loginViewModel.isLoading
                          ? null
                          : () async {
                        if (_formKey.currentState!.validate()) {
                          final String email = _emailController.text.trim();
                          final String password = _passwordController.text.trim();

                          await loginViewModel.authenticateUser(email, password);

                          if(loginViewModel.authResponseModel.errorCode ==0 && loginViewModel.authResponseModel.errorMsg?.compareTo('Success')==0){
                            _navigateToProductPage();
                          }
                        }
                      },
                      child: loginViewModel.isLoading
                          ? const CircularProgressIndicator() // Show loading indicator if isLoading is true
                          : const Text(loginButtonText),
                    ),
                  ],
                ),
              );
            },
          ), // Your login form widget
        ),
      ),
    );
  }

  bool isValidEmail(String email) {
    // Basic email validation regex pattern
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }
  _navigateToProductPage(){
    Navigator.pushReplacementNamed(context, productPageRoute);
  }

}