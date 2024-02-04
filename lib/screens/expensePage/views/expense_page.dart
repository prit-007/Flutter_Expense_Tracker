import 'package:flutter/material.dart';

import '../../../componants/my_card.dart';
import '../../../data/expenses.dart';

class ExpensePage extends StatelessWidget {
  Map<dynamic, dynamic> expense={};
  ExpensePage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

    );
  }
}
