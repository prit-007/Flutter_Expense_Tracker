import 'package:expense_tracker/screens/analytics/views/my_chart.dart';
import 'package:expense_tracker/screens/home/views/home_app_bar.dart';
import 'package:flutter/material.dart';

import '../../../componants/responsive_util.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HomeAppBar(),
          SizedBox(
            height: 10,
          ),
          Text(
            "Transaction",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ResponsiveUtil.getHeadingTitleFont(context),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: ResponsiveUtil.getHeight(context) / 2,
            width: ResponsiveUtil.getWidth(context) / 1.1,
            child: MyChart(),
          ),
        ],
      ),
    );
  }
}
