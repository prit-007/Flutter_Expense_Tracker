import 'dart:math';

import 'package:expense_tracker/componants/responsive_util.dart';
import 'package:expense_tracker/screens/newExpense/views/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  final Map<dynamic, dynamic> expense;

  ExpensePage({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 3,
        title: Text(
          expense['name'],
          style: TextStyle(
            fontSize: ResponsiveUtil.getPageTitleFont(context),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewExpensePage(expense: expense),
                ),
              );
            },
            icon: Icon(
              CupertinoIcons.square_pencil,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      transform: GradientRotation(pi / 4),
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      expense['icon'],
                      color: Colors.blue,
                      size: ResponsiveUtil.getWidth(context) / 2.5,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      expense['type'] == "e"
                          ? CupertinoIcons.arrow_up_circle_fill
                          : CupertinoIcons.arrow_down_circle_fill,
                      size: ResponsiveUtil.getIconSize(context),
                      color: expense['type'] == "e"
                          ? Colors.red.shade200
                          : Colors.green.shade200,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "\$${expense['amount']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getSubTitleFont(context),
                        fontWeight: FontWeight.bold,
                        color: expense['type'] == "e"
                            ? Colors.red.shade200
                            : Colors.green.shade200,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade200,
                  thickness: 1,
                ),
                SizedBox(height: 10),
                getMyText(context, text: expense['description']),
                SizedBox(height: 10),
                getMyText(context, text: "Type: ${expense['category']}"),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${expense['time']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getNormalFont(context),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Text(
                      "${expense['day']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getNormalFont(context),
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Text getMyText(BuildContext context, {required String text}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontSize: ResponsiveUtil.getSubTitleFont(context),
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey.shade400,
    ),
  );
}
