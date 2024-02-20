import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/componants/my_card2.dart';
import 'package:expense_tracker/screens/home/views/home_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../componants/responsive_util.dart';
import '../../../services/firestore_service.dart';
import '../../all_expenses/views/all_expenses.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    var normalFont = ResponsiveUtil.getNormalFont(context);
    var titleFont = ResponsiveUtil.getPageTitleFont(context);
    var subTitleFont = ResponsiveUtil.getSubTitleFont(context) * 0.95;
    var headingTitleFont = ResponsiveUtil.getHeadingTitleFont(context);
    var headingSubtitleFont =
        ResponsiveUtil.getHeadingSubtitleFont(context) * 0.9;

    final user = FirebaseAuth.instance.currentUser!;

    return SingleChildScrollView(
      child: Column(
        children: [
          HomeAppBar(),
          SizedBox(
            height: 15,
          ),
          FutureBuilder<Map<String, dynamic>?>(
            future: FirestoreService.getCurrentUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData) {
                // User not signed in or no data found
                return Text('No user data found. Please sign in or sign up.');
              }

              final userData = snapshot.data!;
              final userName = userData['userName'];
              final budget = userData['budget']?.toString() ?? "Not Set";

              return Container(
                height: ResponsiveUtil.getHeight(context) / 3.75,
                margin: ResponsiveUtil.getMargin(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
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
                      offset: Offset(5, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
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
                                fontSize: headingSubtitleFont,
                              ),
                            ),
                            Text(
                              "\$ ${budget}",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: headingTitleFont,
                              ),
                            ),
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
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
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
                                        fontSize: headingSubtitleFont,
                                      ),
                                    ),
                                    Text(
                                      "\$ 3000",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: titleFont,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    shape: BoxShape.circle,
                                  ),
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
                                        fontSize: headingSubtitleFont,
                                      ),
                                    ),
                                    Text(
                                      "\$ 3000",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: titleFont,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AllExpenses()));
                },
                child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: subTitleFont,
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirestoreService.getUserExpenses(user.email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              final expenses = snapshot.data?.docs;

              if (expenses == null || expenses.isEmpty) {
                return Center(child: Text('NO EXPENSES'));
              }

              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: expenses.length > 6 ? 6 : expenses.length,
                itemBuilder: (context, index) {
                  return MyCustomCard2(
                    expense: expenses[expenses.length - index - 1].data()
                        as Map<String, dynamic>,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
