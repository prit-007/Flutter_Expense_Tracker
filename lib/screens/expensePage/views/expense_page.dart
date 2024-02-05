import 'dart:math';

import 'package:expense_tracker/data/responsive_util.dart';
import 'package:expense_tracker/screens/newExpense/views/new_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensePage extends StatelessWidget {
  Map<dynamic, dynamic> expense = {};

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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                            color: Colors.grey.shade400,
                            blurRadius: 4,
                            offset: Offset(5, 5))
                      ]),
                  child: Card(
                    elevation: 2,
                    margin: EdgeInsets.all(15),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        expense['icon'],
                        color: Colors.blue,
                        size: ResponsiveUtil.getWidth(context) / 2.5,
                        weight: 4,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
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
                      weight: 4,
                    ),
                    Text(
                      "\$${expense['amount']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getIconSize(context),
                        fontWeight: FontWeight.w500,
                        color: expense['type'] == "e"
                            ? Colors.red.shade200
                            : Colors.green.shade200,
                      ),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.grey.shade200,
                ),
                getMyText(context, text: expense['description']),
                getMyText(context, text: "Type:- ${expense['category']}"),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${expense['time']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getPageTitleFont(context),
                        color: Colors.grey.shade400,
                      ),
                    ),
                    Text(
                      "${expense['day']}",
                      style: TextStyle(
                        fontSize: ResponsiveUtil.getPageTitleFont(context),
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

Text getMyText(BuildContext context, {required text}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: ResponsiveUtil.getHeadingTitleFont(context),
      fontWeight: FontWeight.w500,
      color: Colors.blueGrey.shade200,
    ),
  );
}
