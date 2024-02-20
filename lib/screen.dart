import 'package:expense_tracker/expense_add.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/model/expense_data.dart';
import 'package:flutter/material.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key});

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  final List<ExpenseData> expenseData = [];

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => ExpenseAddBtmSheet(
              expeseSubmit: (expense) {
                setState(() {
                  expenseData.add(expense);
                });
              },
            ));
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
                  itemCount: expenseData.length,
                  itemBuilder: (ctx, idx) => Dismissible(
                        key: ValueKey(expenseData[idx]),
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
                          expenseData.removeAt(idx);
                        },
                        child: ExpenseItem(
                          expenseData: expenseData[idx],
                        ),
                      )),
            )
          ],
        ),
      ),
    );
  }
}
