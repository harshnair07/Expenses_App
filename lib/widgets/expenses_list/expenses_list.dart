import 'package:expense_tracker/models/expenditure.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemovedExpense,
  });
  final void Function(Expenditure expenditure) onRemovedExpense;
  final List<Expenditure> expenses;
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(
          expenses[index],
        ),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.80),
          margin: const EdgeInsets.symmetric(horizontal: 16),
        ),
        onDismissed: (direction) {
          onRemovedExpense(expenses[index]);
        },
        child: ExpenseItem(
          expenses[index],
        ),
      ),
    );
  }
}
/// listview isliye use kiye kyuki agr column use krte toh we are not aware ki kitna entries ho skta jiske krn visiblitu and effiency chala jayega isliye list view use kr rhe and it supports scrollabe view also
/// ctx , index ka role yeh hai agr item count 2 hai i.e 2 item in list toh index function will be called twice 
/// => means return 
/// //this ValueKey is a flutter provided constructor which creates a key object which can be used as a value
/// //dismissible is used delete the item using swiping!!!