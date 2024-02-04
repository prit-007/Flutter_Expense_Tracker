import 'package:expense_tracker/data/responsive_util.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewExpensePage extends StatefulWidget {
  NewExpensePage({super.key});

  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  void initState() {
    dateController.text = DateTime.now().toString();
    super.initState();
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "N E W  E X P E N S E",
                style: TextStyle(
                    fontSize: ResponsiveUtil.getPageTitleFont(context),
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            width: ResponsiveUtil.getWidth(context) * 0.7,
            child: TextFormField(
              controller: amountController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  FontAwesomeIcons.dollarSign,
                  color: Colors.grey,
                  size: ResponsiveUtil.getPageTitleFont(context),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32),
                    borderSide: BorderSide.none),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: ResponsiveUtil.getWidth(context) * 0.85,
            child: TextFormField(
              controller: categoryController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  FontAwesomeIcons.list,
                  size: ResponsiveUtil.getSubTitleFont(context),
                  color: Colors.grey,
                ),
                hintText: "Category",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: ResponsiveUtil.getWidth(context) * 0.85,
            child: TextFormField(
              controller: dateController,
              onTap: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(
                    Duration(days: 365),
                  ),
                );
              },
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  FontAwesomeIcons.calendar,
                  size: ResponsiveUtil.getSubTitleFont(context),
                  color: Colors.grey,
                ),
                hintText: "Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: ResponsiveUtil.getWidth(context) * .9,
            height: ResponsiveUtil.getHeight(context) * .06,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              onPressed: () {
                print("object");
              },
              child: Text(
                "S A V E",
                style: TextStyle(
                  fontSize: ResponsiveUtil.getSubTitleFont(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
