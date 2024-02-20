import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      body: FutureBuilder<QuerySnapshot>(
        future: FirestoreService.getUserExpenses(FirebaseAuth.instance.currentUser!.email),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final expensesDocs = snapshot.data!.docs;
          if (expensesDocs.isEmpty) {
            return Center(child: Text('No records found'));
          }
          return GridView.builder(
            itemCount: expensesDocs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.of(context).orientation ==
                  Orientation.portrait
                  ? 2
                  : 3, // Adjust the cross axis count for portrait and landscape
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemBuilder: (context, index) {
              return MyCustomCard(expense: expensesDocs[index].data() as Map<String,dynamic>); // Pass the index directly
            },
          );
        },
      ),
    );
  }
}
