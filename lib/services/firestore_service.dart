import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('USERS');
  static FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<Map<String, dynamic>?> getCurrentUserData() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final QuerySnapshot userSnapshot =
            await usersCollection.where('email', isEqualTo: user.email).get();

        if (userSnapshot.docs.isNotEmpty) {
          final userData = userSnapshot.docs.first.data();
          print(userData);
          return userData as Map<String, dynamic>;
        } else {
          print('No user document found for ${user.email}');
          return null;
        }
      } else {
        print('No user currently signed in');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  static Future<QuerySnapshot> getUserExpenses(String? userEmail) async {
    try {
      // Query for the user document using the email
      QuerySnapshot userQuerySnapshot = await FirebaseFirestore.instance
          .collection('USERS')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      // If user document exists, get expenses collection
      if (userQuerySnapshot.docs.isNotEmpty) {
        String userId = userQuerySnapshot.docs.first.id;
        QuerySnapshot expensesQuerySnapshot = await FirebaseFirestore.instance
            .collection('USERS')
            .doc(userId)
            .collection('expenses')
            .get();

        return expensesQuerySnapshot;
      } else {
        throw 'User document not found';
      }
    } catch (e) {
      throw 'Error fetching user expenses: $e';
    }
  }

  static Future<void> addExpense(
      String userEmail, Map<String, dynamic> expenseData) async {
    try {
      // Query for the user document using the email
      QuerySnapshot userQuerySnapshot = await _firestore
          .collection('USERS')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      // If user document exists, get expenses collection
      if (userQuerySnapshot.docs.isNotEmpty) {
        String userId = userQuerySnapshot.docs.first.id;
        CollectionReference expensesCollection =
            _firestore.collection('USERS').doc(userId).collection('expenses');

        // Add the expense data to the 'expenses' collection
        await expensesCollection.add(expenseData);
      } else {
        throw 'User document not found';
      }
    } catch (e) {
      throw 'Error adding expense: $e';
    }
  }

  static Future<void> deleteExpense(String userEmail, String expenseId) async {
    try {
      // Query for the user document using the email
      QuerySnapshot userQuerySnapshot = await _firestore
          .collection('USERS')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      // If user document exists, get expenses collection
      if (userQuerySnapshot.docs.isNotEmpty) {
        String userId = userQuerySnapshot.docs.first.id;
        DocumentReference expenseRef = _firestore
            .collection('USERS')
            .doc(userId)
            .collection('expenses')
            .doc(expenseId);

        // Delete the expense document
        await expenseRef.delete();
      } else {
        throw 'User document not found';
      }
    } catch (e) {
      throw 'Error deleting expense: $e';
    }
  }

  static Future<void> editExpense(
      String userEmail, String expenseId, Map<String, dynamic> newData) async {
    try {
      // Query for the user document using the email
      QuerySnapshot userQuerySnapshot = await _firestore
          .collection('USERS')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      // If user document exists, get expenses collection
      if (userQuerySnapshot.docs.isNotEmpty) {
        String userId = userQuerySnapshot.docs.first.id;
        DocumentReference expenseRef = _firestore
            .collection('USERS')
            .doc(userId)
            .collection('expenses')
            .doc(expenseId);

        // Update the expense document with the new data
        await expenseRef.update(newData);
      } else {
        throw 'User document not found';
      }
    } catch (e) {
      throw 'Error editing expense: $e';
    }
  }
}
