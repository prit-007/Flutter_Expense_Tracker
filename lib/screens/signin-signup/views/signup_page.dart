import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../componants/responsive_util.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback showLoginPage;

  const SignupPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  String? _errorMessage;

  Future<void> signUp() async {
    if (_formKey.currentState!.validate()) {
      if (_confirmPasswordController.text.trim() ==
          _passwordController.text.trim()) {
        try {
          // Create user in FirebaseAuth
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          // Create user document in Firestore

          await FirebaseFirestore.instance.collection("USERS").add({
            'userName': _usernameController.text.trim(),
            'email': _emailController.text.trim(),
            'createdAt': DateFormat("MMMM d, y").format(DateTime.now()),
            'loginHistory': [],
            'budget': null,
          });

          // Create expenses collection under the user document
          // await userDocRef.collection('expenses').add({});
        } on FirebaseAuthException catch (e) {
          setState(() {
            _errorMessage = e.message;
          });
        }
      } else {
        setState(() {
          _errorMessage = "Passwords do not match";
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields correctly'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

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
                      "Sign Up",
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
                          controller: _usernameController,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            border: InputBorder.none,
                            prefixIcon: Icon(CupertinoIcons.person),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your username';
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
                              return 'Please enter your password';
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
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            border: InputBorder.none,
                            prefixIcon: Icon(CupertinoIcons.lock),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please confirm your password';
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
                          onPressed: signUp,
                          child: Text(
                            "S I G N  U P",
                            style: TextStyle(
                              fontSize: ResponsiveUtil.getSubTitleFont(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text(
                    'Already User??  Sign In',
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
