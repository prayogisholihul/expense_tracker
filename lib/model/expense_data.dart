import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final String uuid = Uuid().toString();
final formatter = DateFormat.yMEd();
DateFormat inputFormat = DateFormat('EEE, M/d/yyyy');

enum Category { food, travel, leisure, work }

class ExpenseData {
  ExpenseData(
      {this.id,
      required this.title,
      required this.amount,
      required this.date,
      required this.category});

  final int? id;
  final String title;
  final int amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, Object?> toMap() => {
        ExpenseDbType.id: id,
        ExpenseDbType.amount: amount,
        ExpenseDbType.title: title,
        ExpenseDbType.date: formattedDate,
        ExpenseDbType.category: category.toString(),
      };

  factory ExpenseData.fromMap(Map<String, dynamic> item) => ExpenseData(
      id: item[ExpenseDbType.id],
      title: item[ExpenseDbType.title],
      amount: item[ExpenseDbType.amount],
      date: inputFormat.parse(item[ExpenseDbType.date]),
      category: parseCategory(item[ExpenseDbType.category]));
}

Category parseCategory(String categoryString) {
  switch (categoryString) {
    case 'Category.food':
      return Category.food;
    case 'Category.travel':
      return Category.travel;
    case 'Category.leisure':
      return Category.leisure;
    case 'Category.work':
      return Category.work;
    default:
      throw ArgumentError('Invalid category string: $categoryString');
  }
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class ExpenseDbType {
  static const String tableName = 'expense';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
  static const String textType = 'TEXT NOT NULL';
  static const String intType = 'INTEGER NOT NULL';
  static const String realType = 'REAL NOT NULL';
  static const String id = 'id';
  static const String title = 'title';
  static const String amount = 'number';
  static const String category = 'category';
  static const String date = 'date';
}
