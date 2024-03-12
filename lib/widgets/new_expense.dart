import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});
  final void Function(Expense expense) addExpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _Selectedcategory = Category.food;
  // hàm submit dữ liệu chi phí
  void _subMitExpenseData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      showDialog(
          context: context,
          builder: ((context) => AlertDialog(
                title: const Text('Invalid Input'),
                content: const Text(
                  'Please enter a valid title and amount and date',
                ),
                actions: <Widget>[
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                    child: const Text('Okey'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )));
      return;
    }
    // gọi hàm addExpense từ widget cha để thêm chi phí mới
    widget.addExpense(Expense(
        title: enteredTitle,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _Selectedcategory));
    // điều hướng trở lại màn hình trước đó
    Navigator.pop(context);
  }

  // hàm hiển thị date picker
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final selectDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _selectedDate = selectDate;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _amountController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                // hiển thị text field nhập số tiền
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '\$',
                    label: Text('amount'),
                  ),
                ),
              ),
              Expanded(
                // hiển thị date picker
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No Date Chosen'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                        onPressed: () {
                          _presentDatePicker();
                        },
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // hiển thị dropdown button để chọn category
              DropdownButton<Category>(
                value: _Selectedcategory,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (value) {
                  if (value == null) return;
                  setState(() {
                    _Selectedcategory = value;
                    print(_Selectedcategory);
                  });
                },
                items: Category.values
                    .map<DropdownMenuItem<Category>>((Category category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // điều hướng trở lại màn hình trước đó
                  Navigator.pop(context);
                },
                child: const Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  _subMitExpenseData();
                },
                child: const Text('Add Expense'),
              )
            ],
          )
        ],
      ),
    );
  }
}
