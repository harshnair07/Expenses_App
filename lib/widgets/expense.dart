//import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/models/expenditure.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Expenditure> _registeredExpenses = [
    Expenditure(
      title: 'Flutter Course',
      amount: 599.0,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expenditure(
      title: 'Cinema',
      amount: 250.0,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expenditure expenditure) {
    setState(
      () {
        _registeredExpenses.add(expenditure);
      },
    );
  }

  void _removeExpense(Expenditure expenditure) {
    final expenseIndex = _registeredExpenses.indexOf(expenditure);
    setState(() {
      _registeredExpenses.remove(expenditure);
    });
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 5),
        content: const Text('Expense Deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expenditure);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.height);

    Widget mainContent = const Center(
      child: Text(
        'No expenses found , Start adding some!',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registeredExpenses, onRemovedExpense: _removeExpense);
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('ExpenseEase'),
          //  backgroundColor: Color.fromARGB(255, 81, 34, 103),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            )
          ],
        ),
        body: width < 600
            ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(
                    child: mainContent,
                  )
                ],
              )
            : Row(
                children: [
                  Expanded(
                    child: Chart(expenses: _registeredExpenses),
                  ),
                  Expanded(
                    child: mainContent,
                  )
                ],
              ));
  }
}
