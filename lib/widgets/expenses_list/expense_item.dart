import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  // khởi tạo một class Expense
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 16,
          ),
          // hiển thị các thuộc tính của class Expense
          child: Column(
            children: [
              // hiển thị tiêu đề chi phí
              Text(
                expense.title,
               style:  const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color:  Colors.black
              ), ),
              Row(
                children: [
                  // hiển thị số tiền chi phí
                  Text(' \$${expense.amount.toStringAsFixed(2)} '),
                  const Spacer(),
                  Row(
                    children: [
                      // hiển thị icon của category
                      Icon(categoryIcons[expense.category]),
                      const SizedBox(width: 8),
                      // hiển thị ngày chi phí
                      Text(expense.FormattedDate.toString()),
                    ],
                  )
                ],
              ),
            ],
          )),
    );
  }
}
