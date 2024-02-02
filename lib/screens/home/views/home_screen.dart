import 'dart:math';
import 'package:expense_tracker/screens/analytics/views/analytics_page.dart';
import 'package:expense_tracker/screens/home/views/home_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../data/size_var.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    int page = 0;

    List<StatelessWidget> pages = [HomeBody(), AnalyticsPage()];
    
    var responsivePadding = ResponsiveUtil.getPadding(context);
    
    return Scaffold(
      body: pages[page],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child:  BottomNavigationBar(
          currentIndex: page,
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.graph_square_fill),
              label: 'History',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          elevation: 0,
          onPressed: () {},
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade200,
                  blurRadius: 5,
                  offset: Offset(5, 5),
                )
              ],
              gradient: LinearGradient(
                transform: GradientRotation(pi / 4),
                colors: [
                  Theme.of(context).colorScheme.tertiary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.primary,
                ],
              ),
            ),
            child: Icon(
              CupertinoIcons.add,
            ),
          ),
        ),
      ),
    );
  }
}
