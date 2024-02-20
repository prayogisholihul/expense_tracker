import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/model/dummy.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  void bottomSheet() {
    showModalBottomSheet(context: context, builder: (ctx) => Container());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [IconButton(onPressed: bottomSheet, icon: Icon(Icons.add))],
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: expenseDummy.length,
                  itemBuilder: (ctx, idx) => Dismissible(
                        key: ValueKey(expenseDummy[idx]),
                        direction: DismissDirection.endToStart,
                        background: Card(
                          color: Colors.red,
                          child: Container(
                              margin: EdgeInsets.only(right: 30),
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.delete,
                              )),
                        ),
                        onDismissed: (direction) {
                          expenseDummy.removeAt(idx);
                        },
                        child: ExpenseItem(
                          expenseData: expenseDummy[idx],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
