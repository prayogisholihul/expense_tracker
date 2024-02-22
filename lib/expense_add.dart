import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_data.dart';

class ExpenseAddBtmSheet extends StatefulWidget {
  ExpenseAddBtmSheet(
      {Key,
      this.expenseData,
      required this.insertExpense,
      required this.updateExpense});

  final void Function(ExpenseData) insertExpense;
  final ExpenseData? expenseData;
  final void Function(ExpenseData) updateExpense;

  @override
  State<ExpenseAddBtmSheet> createState() => _ExpenseAddBtmSheetState();
}

class _ExpenseAddBtmSheetState extends State<ExpenseAddBtmSheet> {
  var expenseData = [];
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category? _selectedCategory;
  DateTime? _selectedDate;

  void pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, now.month, now.day);
    final lastDate = DateTime(now.year + 5, now.month, now.day);
    final date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = date;
    });
  }

  void submit() {
    if (_titleController.text.trim().isNotEmpty ||
        _amountController.text.trim().isNotEmpty ||
        _selectedDate != null ||
        _selectedCategory != null) {
      final data = ExpenseData(
          id: widget.expenseData?.id,
          title: _titleController.text.trim(),
          amount: int.parse(_amountController.text),
          date: _selectedDate!,
          category: _selectedCategory!);

      if (widget.expenseData?.id != null) {
        widget.updateExpense(data);
        Navigator.pop(context);
        return;
      }

      widget.insertExpense(data);
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    if (widget.expenseData != null) {
      _titleController.text = widget.expenseData!.title;
      _amountController.text = widget.expenseData!.amount.toString();
      _selectedDate = widget.expenseData!.date;
      _selectedCategory = widget.expenseData!.category;
    }
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountController,
                  decoration: InputDecoration(
                      label: Text('Amount'), prefix: Text('\$')),
                ),
              ),
              InkWell(
                onTap: pickDate,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    SizedBox(
                      width: 12,
                    ),
                    Icon(Icons.date_range)
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          DropdownButton(
            hint: Text('Category'),
            value: _selectedCategory,
            items: Category.values
                .map((category) => DropdownMenuItem(
                      value: category,
                      // ignore: sdk_version_since
                      child: Text(category.name),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value as Category;
              });
            },
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              SizedBox(
                width: 8,
              ),
              ElevatedButton(onPressed: submit, child: Text('Save Expense'))
            ],
          )
        ],
      ),
    );
  }
}
