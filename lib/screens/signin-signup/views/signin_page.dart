import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/componants/navigation_util.dart';
import 'package:expense_tracker/componants/responsive_util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showSignUpPage;

  const LoginPage({super.key, required this.showSignUpPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  Future<void> signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Fetch the user document from Firestore
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("USERS")
            .where('email', isEqualTo: _emailController.text.trim())
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs.first;

          // Get the existing loginHistory array or initialize it if null
          List<dynamic> loginHistory = (userDoc.data() as Map<String, dynamic>)['loginHistory'] ?? [];

          // Add current date and time to the loginHistory array
          loginHistory.add(DateTime.now().toString());

          // Update the user document with the new loginHistory array
          await userDoc.reference.update({'loginHistory': loginHistory});
        } else {
          // Handle case where user document doesn't exist
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          _errorMessage = e.message;
        });
        _showErrorSnackbar();
      }
    }
  }


  void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_errorMessage ?? 'An error occurred.'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFFF8D6C),
                Color(0xFF00B2E7),
                Color(0xFFE064F7),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getHeadingTitleFont(context),
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(
                          ResponsiveUtil.getWidth(context) * 0.005,
                        ),
                        padding: EdgeInsets.all(
                          ResponsiveUtil.getWidth(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            prefixIcon: Icon(CupertinoIcons.mail),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            // Email format validation
                            bool isValidEmail =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                    .hasMatch(value);
                            if (!isValidEmail) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.all(
                          ResponsiveUtil.getWidth(context) * 0.005,
                        ),
                        padding: EdgeInsets.all(
                          ResponsiveUtil.getWidth(context) * 0.02,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            prefixIcon: Icon(CupertinoIcons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter your password';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 40),
                      SizedBox(
                        width: ResponsiveUtil.getWidth(context) * .9,
                        height: ResponsiveUtil.getHeight(context) * .06,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          onPressed: signIn,
                          child: Text(
                            "S I G N  I N",
                            style: TextStyle(
                              fontSize: ResponsiveUtil.getSubTitleFont(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextButton(
                        onPressed: widget.showSignUpPage,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          NavigationUtil.navigateWithSlideTransition(
                            context,
                            ForgotPasswordPage(),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
