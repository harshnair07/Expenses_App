import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd(); //ymd defines how date will be formatted

const uuid = Uuid();

enum Category { food, travel, leisure, work, grocery }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff_outlined,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
  Category.grocery: Icons.local_grocery_store,
};

class Expenditure {
  Expenditure({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); // uuid is a third party package we are using for the automatic generation of id

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({
    required this.category,
    required this.expenditure,
  });
  ExpenseBucket.forCategory(List<Expenditure> allExpenses, this.category)
      : expenditure = allExpenses
            .where((expenditure) => expenditure.category == category)
            .toList();
  final Category category;
  final List<Expenditure> expenditure;

  double get totalExpense {
    double sum = 0;

    for (final expense in expenditure) {
      sum += expense.amount;
    }
    return sum;
  }
}
