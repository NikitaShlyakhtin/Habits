import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:provider/provider.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final Habit habit;
  const ConfirmDeleteDialog(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(
      builder: (context, habitList, child) => AlertDialog(
        title: const Text('Are you sure?'),
        content:
            const Text('All data about this habit will be permanently deleted'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              habitList.remove(habit);
              Navigator.pop(context, 'OK');
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
