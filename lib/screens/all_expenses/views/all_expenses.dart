import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../componants/my_card.dart';
import '../../../data/expenses.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TRANSACTION HISTORY"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              print("sorted");
            },
            icon: Icon(CupertinoIcons.line_horizontal_3_decrease_circle),
          )
        ],
      ),
      body: GridView.builder(
        itemCount: expenses.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).orientation ==
              Orientation.portrait
              ? 2
              : 3, // Adjust the cross axis count for portrait and landscape
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemBuilder: (context, index) {
          return MyCustomCard(index: expenses.length - index - 1);
        },
      ),
    );
  }
}
