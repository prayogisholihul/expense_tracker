import 'package:expense_tracker/database.dart';
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
  final ExpenseDB database = ExpenseDB.instance;
  List<ExpenseData> expenseData = [];

  void bottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => ExpenseAddBtmSheet(
              submitExpense: (expense) async {
                await database.insert(expense);
                initData();
              },
            ));
  }

  @override
  void initState() {
    initData();
    super.initState();
  }

  void initData() async {
    final data = await database.getAll();
    setState(() {
      expenseData = data;
    });
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
                        key: Key(expenseData[idx].id.toString()),
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
                          database.delete(expenseData[idx].id!);
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
