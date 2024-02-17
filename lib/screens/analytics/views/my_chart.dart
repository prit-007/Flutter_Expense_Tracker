import 'dart:math';
import 'dart:ui';

import 'package:expense_tracker/data/expenses.dart';
import 'package:expense_tracker/componants/responsive_util.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyChart extends StatelessWidget {
  const MyChart({super.key});

  @override
  Widget build(BuildContext context) {
    // Categorize expenses based on type
    Map<String, double> categoryExpenses = {};
    for (var expense in expenses) {
      categoryExpenses[expense['category']] =
          (categoryExpenses[expense['category']] ?? 0) +
              double.parse(expense['amount']);
    }

    // Group expenses by day
    Map<String, List<Map<dynamic, dynamic>>> expensesByDay = {};
    for (var expense in expenses) {
      expensesByDay[expense['day']] ??= [];
      expensesByDay[expense['day']]?.add(expense);
    }

    return Container(
      child: Column(
        children: [
          Container(
            height: ResponsiveUtil.getHeight(context)/3,
            child: PieChart(
              swapAnimationCurve: Easing.standardAccelerate,
              swapAnimationDuration: Duration(milliseconds: 700),
              PieChartData(
                sectionsSpace: 1,
                pieTouchData: PieTouchData(),
                sections: categoryExpenses.entries.map((entry) {
                  return PieChartSectionData(
                    showTitle: true,
                    radius: ResponsiveUtil.getHeight(context)/6,
                    value: entry.value,
                    color: _getRandomColor(),
                    title: entry.key,
                    badgeWidget: Text(
                      "\$${entry.value}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getSubTitleFont(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    badgePositionPercentageOffset: .7,
                    titlePositionPercentageOffset: .3,
                    titleStyle: TextStyle(
                      fontSize: ResponsiveUtil.getSubTitleFont(context),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextButton(
            onPressed: () {
              print(categoryExpenses);
            },
            child: Icon(Icons.access_alarm_outlined),
          )
        ],
      ),
    );
  }

  Color _getRandomColor() {
    return Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
  }
}
