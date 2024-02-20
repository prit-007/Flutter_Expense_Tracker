import 'package:expense_tracker/componants/responsive_util.dart';
import 'package:flutter/material.dart';

import '../data/expenses.dart';
import '../screens/expensePage/views/expense_page.dart';
import 'navigation_util.dart';

class MyCustomCard2 extends StatelessWidget {
  final Map<String,dynamic> expense;

  MyCustomCard2({Key? key, required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    var iconSize = MediaQuery.of(context).size.height * 0.04;

    return InkWell(
      onTap: () {
        NavigationUtil.navigateWithFadeTransition(
          context,
          ExpensePage(expense: expense),
        );
      },
      child: Card(
        surfaceTintColor: expense['type'] == 'i'
            ? Colors.greenAccent.shade100
            : Colors.redAccent.shade100,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(
            ResponsiveUtil.getWidth(context) * 0.03,
          ), // Increased padding
          leading: CircleAvatar(
            backgroundColor: expense['type'] == 'e'
                ? Colors.red[100]
                : Colors.green[100],
            child: Icon(
              expense['icon'],
              size: 20,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      expense['name'],
                      style: TextStyle(
                        fontSize: subTitleFont * 1.3,
                        fontWeight: FontWeight.bold,
                        color: expense['type'] == 'e'
                            ? Colors.red
                            : Colors.green,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "\$ " + expense['amount'],
                      style: TextStyle(
                        fontSize: subTitleFont,
                        fontWeight: FontWeight.bold,
                        color: expense['type'] == 'e'
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    expense['day'],
                    style: TextStyle(fontSize: normalFont, color: Colors.grey),
                  ),
                  Text(
                    expense['time'],
                    style: TextStyle(fontSize: normalFont, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
