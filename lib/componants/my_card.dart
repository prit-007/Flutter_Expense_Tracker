import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data/expenses.dart';
import '../data/size_var.dart';

class MyCard extends StatelessWidget {
  var index;

  MyCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var titleFont = ResponsiveUtil.getTitleFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    var mediaWidth = ResponsiveUtil.getWidth(context);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        width: mediaWidth * 0.4, // Adjust width percentage as needed
        child: Column(
          children: [
            Flexible(
              child: Icon(
                expenses[index]['icon'],
                size: 40,
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              child: Text(
                expenses[index]['name'],
                style: TextStyle(
                  fontSize: subTitleFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    expenses[index]['type'] == 'e'
                        ? CupertinoIcons.arrow_up_circle_fill
                        : CupertinoIcons.arrow_down_circle_fill,
                    size: 20,
                    color: expenses[index]['type'] == 'e'
                        ? Colors.red.shade200
                        : Colors.green.shade200,
                  ),
                  Row(
                    children: [
                      Icon(
                        (expenses[index]['type'] == 'e'
                            ? CupertinoIcons.minus
                            : CupertinoIcons.add),
                        size: normalFont,
                        color: expenses[index]['type'] == 'e'
                            ? Colors.red.shade200
                            : Colors.green.shade200,
                      ),
                      Text(
                        "\$ " + expenses[index]['amount'],
                        style: TextStyle(
                          fontSize: normalFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
