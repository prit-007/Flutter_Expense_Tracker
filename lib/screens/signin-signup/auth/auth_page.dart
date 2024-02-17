import 'package:expense_tracker/screens/signin-signup/views/signin_page.dart';
import 'package:expense_tracker/screens/signin-signup/views/signup_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        showSignUpPage: toggleScreen,
      );
    } else {
      return SignupPage(
        showLoginPage: toggleScreen,
      );
    }
  }

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
}
