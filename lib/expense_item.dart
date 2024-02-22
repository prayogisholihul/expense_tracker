import 'package:flutter/material.dart';
import 'package:expense_tracker/model/expense_data.dart';

class ExpenseItem extends StatefulWidget {
  const ExpenseItem({Key, required this.expenseData});

  final ExpenseData expenseData;

  @override
  State<ExpenseItem> createState() => _ExpenseItemState();
}

class _ExpenseItemState extends State<ExpenseItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(
          children: [
            Text(
              widget.expenseData.title,
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\Rp. ${widget.expenseData.amount}',
                  style: TextStyle(color: Colors.black),
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(categoryIcons[widget.expenseData.category]),
                      SizedBox(
                        width: 12,
                      ),
                      Text(widget.expenseData.formattedDate,
                          style: TextStyle(color: Colors.black))
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
