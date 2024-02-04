import 'dart:math';

import 'package:expense_tracker/componants/my_card.dart';
import 'package:expense_tracker/data/expenses.dart';
import 'package:expense_tracker/screens/home/views/home_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/responsive_util.dart';
import '../../all_expenses/views/all_expenses.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var titleFont = ResponsiveUtil.getPageTitleFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context);
    var headingTitleFont = ResponsiveUtil.getHeadingTitleFont(context);
    var headingSubtitleFont = ResponsiveUtil.getHeadingSubtitleFont(context);
    return Column(
      children: [
        HomeAppBar(),
        SizedBox(
          height: 15,
        ),
        Container(
          height: ResponsiveUtil.getHeight(context)/3,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Column(
                    children: [
                      Text(
                        "Total Balance",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: headingSubtitleFont),
                      ),
                      Text(
                        "\$ 3000",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: headingTitleFont),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.upload_circle,
                                    size: 35,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Expense",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: headingSubtitleFont),
                                  ),
                                  Text(
                                    "\$ 3000",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: titleFont),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle),
                                child: Center(
                                  child: Icon(
                                    CupertinoIcons.download_circle,
                                    size: 35,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Total Income",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: headingSubtitleFont),
                                  ),
                                  Text(
                                    "\$ 3000",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: titleFont,
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Recent Transactions",
              style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllExpenses()));
              },
              child: Text(
                "View All",
                style: TextStyle(
                    fontSize: subTitleFont,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Expanded(
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).orientation ==
                  Orientation.portrait
                  ? 2
                  : 3, // Adjust the cross axis count for portrait and landscape
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) {
              return MyCustomCard(index: expenses.length-index-1);
            },
          ),
        ),
      ],
    );
  }
}
