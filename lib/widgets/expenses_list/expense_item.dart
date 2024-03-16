import 'package:expense_tracker/models/expenditure.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expenditure, {super.key});

  final Expenditure expenditure;

  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenditure.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text('\Rs ${expenditure.amount.toStringAsFixed(2)}'),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expenditure.category]),
                    SizedBox(
                      width: 8,
                    ),
                    Text(expenditure.formattedDate),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
//cardview is used to elevation and to give a stylish and elegant look . It also add some top and bottom margin.