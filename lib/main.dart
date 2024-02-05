import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expense_tracker/screens/home/views/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'data/responsive_util.dart';

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
        title: 'Pocket Buddy',
        theme: ThemeData(
          colorScheme: ColorScheme.light(
              background: Colors.grey.shade100,
              onBackground: Colors.black,
              primary: Color(0xFF00B2E7),
              secondary: Color(0xFFE064F7),
              tertiary: Color(0xFFFF8D6C)),
          useMaterial3: true,
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: ResponsiveUtil.getWidth(context) / 2,
          splash: Icon(
            FontAwesomeIcons.wallet,
            size: ResponsiveUtil.getWidth(context) / 3,
          ),
          nextScreen: Scaffold(
            body: HomePage(),
          ),
          splashTransition: SplashTransition.slideTransition,
          curve: Curves.linear,
          pageTransitionType: PageTransitionType.leftToRight,
          backgroundColor: Color(0xFFE064F7),
        ),
      ),
    );
  }
}
