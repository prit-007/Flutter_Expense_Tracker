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

  @override
  Widget build(BuildContext context) {
    int page = 0;
    List pages = [HomeBody(),AnalyticsPage()];

    return Scaffold(
      body: pages[page],
      bottomNavigationBar: GNav(
        onTabChange: (index){
          page = index;
        },
        selectedIndex: page,
        tabs: [
          GButton(icon: CupertinoIcons.house_fill),
          GButton(icon: CupertinoIcons.graph_square_fill)
        ],
      ),
    );
  }
}
