import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/expenses.dart';
import 'responsive_util.dart';
import '../screens/expensePage/views/expense_page.dart';

class MyCustomCard extends StatelessWidget {
  final int index;

  MyCustomCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    var iconSize = ResponsiveUtil.getIconSize(context);

    return InkWell(
      onTap: () {
        // Navigate to ExpensePage when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExpensePage(expense: expenses[index]),
          ),
        );
      },
      child: Container(
        margin: ResponsiveUtil.getMargin(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(ResponsiveUtil.getWidth(context) * 0.01),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                expenses[index]['icon'],
                size: iconSize,
                color: Colors.blue,
              ),
              SizedBox(height: 8),
              Text(
                expenses[index]['name'],
                style: TextStyle(
                  fontSize: subTitleFont,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: null,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    expenses[index]['type'] == 'e'
                        ? CupertinoIcons.arrow_up_circle_fill
                        : CupertinoIcons.arrow_down_circle_fill,
                    size: subTitleFont,
                    color: expenses[index]['type'] == 'e'
                        ? Colors.red.shade200
                        : Colors.green.shade200,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "\$ " + expenses[index]['amount'],
                    style: TextStyle(
                      fontSize: subTitleFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    expenses[index]['day'],
                    style: TextStyle(
                      fontSize: normalFont,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    expenses[index]['time'],
                    style: TextStyle(
                      fontSize: normalFont,
                      color: Colors.grey,
                    ),
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
