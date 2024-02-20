import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/screens/home/views/home.dart';
import 'package:expense_tracker/screens/signin-signup/auth/auth_page.dart';
import 'package:expense_tracker/screens/signin-signup/views/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:page_transition/page_transition.dart';

import 'componants/responsive_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pocket Buddy',
        theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            background: Colors.grey.shade100,
            onBackground: Colors.black,
            primary: Color(0xFF00B2E7),
            secondary: Color(0xFFE064F7),
            tertiary: Color(0xFFFF8D6C),
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark(
            background: Colors.black,
            onBackground: Colors.white,
            primary: Color(0xFF00B2E7),
            secondary: Color(0xFFE064F7),
            tertiary: Color(0xFFFF8D6C),
          ),
        ),
        themeMode: ThemeMode.system, // Use system theme mode
        home: AnimatedSplashScreen(
          duration: 3000,
          splashIconSize: ResponsiveUtil.getWidth(context) / 2,
          splash: Icon(
            FontAwesomeIcons.wallet,
            size: ResponsiveUtil.getWidth(context) / 3,
          ),
          nextScreen: Scaffold(
            body: StreamBuilder<User?>(
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return HomePage();
                }
                else{
                  return AuthPage();                }
              },
              stream: FirebaseAuth.instance.authStateChanges(),
            ),
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