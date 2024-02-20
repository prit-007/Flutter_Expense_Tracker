import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Expense {
  final String name;
  final String description;
  final String amount;
  final String time;
  final String day;
  final String category;
  final IconData icon;
  final String type;

  Expense({
    required this.name,
    required this.description,
    required this.amount,
    required this.time,
    required this.day,
    required this.category,
    required this.icon,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'amount': amount,
      'time': time,
      'day': day,
      'category': category,
      'icon': icon.codePoint,
      'type': type,
    };
  }
}
List<Map<dynamic, dynamic>> expenses = [
  {"name": "astalavista","description":"asdf", "amount": "560", "time": "22:34","day":"Sunday", "category": "k", "icon": Icons.home, "type":"e"},
  {"name": "bsdfgghghlkhjgfad","description":"asdf", "amount": "340", "time": "20:89","day":"Sunday", "category": "k", "icon": Icons.add,"type":"i"},
  {"name": "c","description":"asdf", "amount": "230", "time": "06:54","day":"Sunday", "category": "o", "icon": Icons.no_adult_content,"type":"e"},
  {"name": "d","description":"asdf", "amount": "910", "time": "09:05","day":"Sunday", "category": "o", "icon": CupertinoIcons.bag,"type":"e"},
  {"name": "f","description":"asdf", "amount": "6959", "time": "09:05","day":"Sunday", "category": "l", "icon": CupertinoIcons.arrow_up_bin_fill,"type":"i"},
  {"name": "e","description":"asdf", "amount": "6000", "time": "09:05","day":"Sunday", "category": "p", "icon": CupertinoIcons.antenna_radiowaves_left_right,"type":"i"},
  {"name": "f","description":"asdf", "amount": "695", "time": "09:05","day":"Sunday", "category": "l", "icon": CupertinoIcons.heart,"type":"e"},
];
