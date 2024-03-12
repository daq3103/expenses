import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';
import 'package:flutter_application_1/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses , required this.removeExpense});
  // khởi tạo danh sách các chi phí
  final List<Expense> expenses;
  // khởi tạo hàm xóa chi phí
  final void Function(Expense expense) removeExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => 
        // tạo một item chi phí từ danh sách chi phí
        Dismissible(key: ValueKey(expenses[index].id), 
        onDismissed: (direction) {
          removeExpense(expenses[index]);
        },
        child: ExpenseItem(expense: expenses[index])) );
  }
}
