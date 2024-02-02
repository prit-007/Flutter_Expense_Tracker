import 'package:flutter/material.dart';

import '../../../data/size_var.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var titleFont = ResponsiveUtil.getTitleFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("TITIIII")  ,
      ),
    );
  }
}
