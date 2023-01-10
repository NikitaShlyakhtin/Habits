import 'package:flutter/material.dart';
import 'package:habit_tracker/util/const.dart';

class ReminderInfo extends StatelessWidget {
  final bool reminder;
  const ReminderInfo(this.reminder, {super.key});

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);
    return Container(
      decoration: boxDecoration,
      padding: blockPadding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: reminder ? 1 : 0.5,
            child: Icon(
              size: 25,
              reminder
                  ? Icons.notifications_outlined
                  : Icons.notifications_off_outlined,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 5),
          Opacity(
              opacity: reminder ? 1 : 0.5,
              child: Text(reminder ? 'Reminder On' : 'Reminder Off',
                  style: const TextStyle(fontSize: 16)))
        ],
      ),
    );
  }
}
