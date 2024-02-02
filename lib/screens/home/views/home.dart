import 'dart:math';

import 'package:expense_tracker/screens/analytics/views/analytics_page.dart';
import 'package:expense_tracker/screens/home/views/home_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 0;
  List<Widget> pages = [HomeBody(), AnalyticsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedPage],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: GNav(
          onTabChange: (index) {
            setState(() {
              selectedPage = index;
            });
          },
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          gap: 15,
          tabs: [
            GButton(
              icon: CupertinoIcons.house_fill,
              text: 'Home',
            ),
            GButton(
              icon: CupertinoIcons.graph_square_fill,
              text: 'Analytics',
            )
          ],
          selectedIndex: selectedPage,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        elevation: 4,
        shape: CircleBorder(),
        hoverColor: Colors.deepPurpleAccent,
        child: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              transform: GradientRotation(pi / 4),
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
            ),
          ),
          child: Icon(CupertinoIcons.add),
        ),
      ),
    );
  }
}
