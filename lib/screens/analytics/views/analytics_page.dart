import 'package:expense_tracker/screens/analytics/views/my_cahrt.dart';
import 'package:expense_tracker/screens/home/views/home_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../data/size_var.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var titleFont = ResponsiveUtil.getTitleFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    var normalFontStyle = ResponsiveUtil.getNormalFontStyle(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          HomeAppBar(),
          SizedBox(height: 10,),
          Text("Transaction",style: normalFontStyle,),
          SizedBox(height: 20,),
          Container(
            height: ResponsiveUtil.getHeight(context),
            width: ResponsiveUtil.getWidth(context),
            child: MyChart()
          )
        ],
      ),
    );
  }
}
