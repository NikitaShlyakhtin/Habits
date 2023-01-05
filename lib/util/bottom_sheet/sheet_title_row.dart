import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit_list.dart';

class SheetTitleRow extends StatelessWidget {
  const SheetTitleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(
      builder: (context, habitList, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
                onPressed: () {
                  habitList.closeBottomSheet(context);
                },
                child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ))),
            const Text('New habit',
                style: TextStyle(fontWeight: FontWeight.w600)),
            TextButton(
                onPressed: () {
                  habitList.add();
                  habitList.closeBottomSheet(context);
                },
                child: Opacity(
                    opacity: 0.5,
                    child: Text(
                      'Done',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ))),
          ],
        );
      },
    );
  }
}
