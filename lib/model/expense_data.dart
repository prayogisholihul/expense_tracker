import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final String uuid = Uuid().toString();
final formatter = DateFormat.yMEd();

enum Category { food, travel, leisure, work }

class ExpenseData {
  ExpenseData(this.title, this.amount, this.date, this.category) : id = uuid;

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
