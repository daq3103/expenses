import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

var uuid = Uuid();
final formatter = DateFormat.yMd();

enum Category { food, travel, leisure, work }

// tạo một map chứa các icon tương ứng với category
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};

class Expense {
  // khởi tạo các thuộc tính
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4(); // tạo id ngẫu nhiên
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String get FormattedDate {
    return formatter.format(date);
  }
}

// tạo một class sumExpense để tính tổng chi phí của mỗi category
class sumExpense {
  final Category category; // loại chi phí
  final List<Expense> expenses; // danh sách chi phí đã được lọc
  const sumExpense({
    required this.category,
    required this.expenses,
  });
  // hàm khởi tạo để lọc ra các chi phí của mỗi category
  sumExpense.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((expense) => expense.category == category)
      .toList();
  // tạo một hàm để tính tổng chi phí của mỗi category
  double get totalExpense {
    double sum = 0;
    for (var i = 0; i < expenses.length; i++) {
      sum = sum + expenses[i].amount;
    }
    return sum;
  }
}
