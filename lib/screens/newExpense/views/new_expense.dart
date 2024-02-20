import 'package:expense_tracker/services/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../componants/responsive_util.dart';

class NewExpensePage extends StatefulWidget {
  final Map<dynamic, dynamic>? expense;

  NewExpensePage({Key? key, this.expense}) : super(key: key);

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController timeController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool isExpense = true;

  // Categories
  final expenseCategories = [
    "Groceries",
    "Utilities",
    "Rent/Mortgage",
    "Transportation",
    "Healthcare/Medical",
    "Entertainment",
    "Dining Out",
    "Shopping",
    "Travel",
    "Education",
    "Insurance",
    "Gifts/Donations",
    "Personal Care",
    "Home Maintenance",
    "Subscriptions",
  ];

  final incomeCategories = [
    "Salary",
    "Freelance Income",
    "Business Income",
    "Investment Income",
    "Rental Income",
    "Gifts/Inheritance",
    "Side Job Income",
    "Alimony",
    "Refunds/Reimbursements",
    "Interest Income",
  ];

  @override
  void initState() {
    // Set initial values based on the provided expense map
    if (widget.expense != null) {
      amountController.text = widget.expense!['amount'];
      titleController.text = widget.expense!['name'];
      dateController.text = widget.expense!['day'];
      categoryController.text = widget.expense!['category'];
      descriptionController.text = widget.expense!['description'] ?? '';
      timeController.text = widget.expense!['time'];
      isExpense = widget.expense!['type'] == 'e';
    } else {
      // Set default date when adding a new expense
      dateController.text = DateFormat("MMMM d, y").format(DateTime.now());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    timeController.text = selectedTime.format(context);
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  widget.expense != null
                      ? "E D I T  E X P E N S E"
                      : "N E W  E X P E N S E",
                  style: TextStyle(
                    fontSize: ResponsiveUtil.getPageTitleFont(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            getSizedBoxHeight(16),
            getMyCupertinoSlidingControl(),
            getSizedBoxHeight(20),
            getMyTextFormField(
              amountController,
              "Amount",
              FontAwesomeIcons.dollarSign,
              () {},
              false, // Amount is not read-only
            ),
            getSizedBoxHeight(20),
            getMyTextFormField(
              titleController,
              "Title",
              FontAwesomeIcons.android,
              () {},
              false, // Amount is not read-only
            ),
            getSizedBoxHeight(20),
            getMyTextFormField(
              categoryController,
              "Category",
              FontAwesomeIcons.list,
              () {
                _showCategoryDialog();
              },
              true, // Category is read-only
            ),
            getSizedBoxHeight(20),
            getMyTextFormField(
              descriptionController,
              "Description",
              FontAwesomeIcons.addressCard,
              () {},
              false, // Description is not read-only
            ),
            getSizedBoxHeight(20),
            getMyTextFormField(
              dateController,
              "Date",
              FontAwesomeIcons.calendar,
              () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime.now().subtract(Duration(days: 365)),
                  lastDate: DateTime.now(),
                );
                if (newDate != null) {
                  setState(() {
                    dateController.text =
                        DateFormat("MMMM d, y").format(newDate);
                    selectedDate = newDate;
                  });
                }
              },
              true, // Date is read-only
            ),
            getSizedBoxHeight(20),
            getMyTextFormField(
              timeController,
              "Time",
              Icons.access_time,
              () async {
                TimeOfDay? newTime = await showTimePicker(
                  context: context,
                  initialTime: selectedTime,
                );
                if (newTime != null) {
                  setState(() {
                    timeController.text = newTime.format(context);
                    selectedTime = newTime;
                  });
                }
              },
              true, // Time is read-only
            ),
            getSizedBoxHeight(20),
            getMyTextButton(
              "S A V E",
              save,
            ),
          ],
        ),
      ),
    );
  }

  Widget getMyTextFormField(
    TextEditingController controller,
    String hintText,
    IconData prefixIcon,
    VoidCallback onTap,
    bool readOnly, // Added readOnly parameter
  ) {
    return SizedBox(
      width: ResponsiveUtil.getWidth(context) * 0.85,
      child: TextFormField(
        controller: controller,
        readOnly: readOnly,
        // Set TextFormField as read-only
        onTap: onTap,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: controller == amountController
            ? TextInputType.numberWithOptions()
            : TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            prefixIcon,
            size: ResponsiveUtil.getSubTitleFont(context),
            color: isExpense
                ? Colors.red
                : Colors.green, // Adjust color based on type
          ),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        validator: (value) {
          if (!readOnly && (value == null || value.isEmpty)) {
            return 'This field should not be empty';
          }
          return null;
        },
      ),
    );
  }

  Widget getMyTextButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: ResponsiveUtil.getWidth(context) * .9,
      height: ResponsiveUtil.getHeight(context) * .06,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontSize: ResponsiveUtil.getSubTitleFont(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getSizedBoxHeight(double height) {
    return SizedBox(height: height);
  }

  Widget getMyCupertinoSlidingControl() {
    return CupertinoSlidingSegmentedControl<bool>(
      backgroundColor: Colors.transparent,
      children: {
        true: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'Expense',
            style: TextStyle(fontSize: ResponsiveUtil.getSubTitleFont(context)),
          ),
        ),
        false: Container(
          padding: EdgeInsets.all(8),
          child: Text(
            'Income',
            style: TextStyle(fontSize: ResponsiveUtil.getSubTitleFont(context)),
          ),
        ),
      },
      onValueChanged: (value) {
        setState(() {
          isExpense = value!;
          // Reset category field when switching between expense and income
          categoryController.text = "";
        });
      },
      groupValue: isExpense,
    );
  }

  //save method onSubmit
  void save() async {
    // Validation for Amount field
    if (amountController.text.isNotEmpty &&
        double.tryParse(amountController.text) != null) {
      // Create or update expense map
      Map<String, dynamic> newExpense = {
        "name": titleController.text,
        "amount": amountController.text,
        "time": timeController.text,
        "day": DateFormat("EEEE").format(selectedDate),
        "category": categoryController.text,
        "type": isExpense ? "e" : "i",
        "description": descriptionController.text.isNotEmpty
            ? descriptionController.text
            : null,
      };

      try {
        final User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          if (widget.expense != null) {
            // If editing an existing expense, update the document
            await FirestoreService.editExpense(
              user.email!,
              widget.expense!['id'],
              //'id' is the field containing the document ID
              newExpense,
            );
          } else {
            // If adding a new expense, add it to the collection
            await FirestoreService.addExpense(
              FirebaseAuth.instance.currentUser!.email!,
              // Pass the current user's email
              newExpense,
            );
          }

          // Navigate back to the previous screen
          Navigator.pop(context);
        } else {
          // Show an error message if user is not signed in
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("User not signed in"),
            ),
          );
        }
      } catch (e) {
        // Show an error message or perform any other actions for errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: $e"),
          ),
        );
      }
    } else {
      // Show an error message or perform any other actions for invalid input
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter a valid amount"),
        ),
      );
    }
  }

  //method for displaying category
  Future<void> _showCategoryDialog() async {
    List<String> categories = isExpense ? expenseCategories : incomeCategories;
    String? selectedCategory = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Category"),
          content: Container(
            height: 200,
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                children: categories.map((category) {
                  return ListTile(
                    title: Text(category),
                    onTap: () {
                      Navigator.pop(context, category);
                    },
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );

    if (selectedCategory != null) {
      setState(() {
        categoryController.text = selectedCategory;
      });
    }
  }
}
