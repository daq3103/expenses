import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';
import 'package:flutter_application_1/widgets/chart/chart.dart';
import 'package:flutter_application_1/widgets/expenses_list/expenses_list.dart';
import 'package:flutter_application_1/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // khởi tạo danh sách các chi phí
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.89,
        date: DateTime.now(),
        category: Category.leisure),
  ];
  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) => NewExpense(addExpense: _addNewExpense),
    );
  }

  void _addNewExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      _registeredExpenses.remove(expense);
    });
    // hiển thị thông báo khi xóa chi phí
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        // hiển thị nút undo để hoàn tác việc xóa chi phí
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(_registeredExpenses.length, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget Content = const Center(child: Text('No expenses added yet!'));
    if (_registeredExpenses.isNotEmpty) {
      Content = ExpensesList(
          expenses: _registeredExpenses, removeExpense: _removeExpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personal Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpense();
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpenses,
          ),
          Expanded(child: Content),
        ],
      ),
    );
  }
}
