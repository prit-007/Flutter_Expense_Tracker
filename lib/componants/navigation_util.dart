import 'package:flutter/material.dart';

class NavigationUtil {
  //normal navigation
  static void navigateTo(BuildContext context, Widget destinationPage) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => destinationPage),
    );
  }
  //navigation with slide
  static void navigateWithSlideTransition(BuildContext context, Widget destinationPage) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);
          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  }

  //navigation with fade
  static void navigateWithFadeTransition(BuildContext context, Widget destinationPage) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  //navigation with scale
  static void navigateWithScaleTransition(BuildContext context, Widget destinationPage) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
      ),
    );
  }
}
