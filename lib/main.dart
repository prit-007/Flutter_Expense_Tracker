import 'package:expense_tracker/screens/home/views/home.dart';
import 'package:flutter/material.dart';

import 'data/size_var.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade100,
            onBackground: Colors.black,
            primary: Color(0xFF00B2E7),
            secondary: Color(0xFFE064F7),
            tertiary: Color(0xFFFF8D6C)
          ),
          useMaterial3: true,
        ),
        home: Scaffold(
          body: Padding(
            padding: ResponsiveUtil.getPadding(context),
            child: HomePage(),
          ),
        ),
      ),
    );
  }
}