import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:provider/provider.dart';

class ChangeHabitFrequency extends StatelessWidget {
  final Habit habit;
  const ChangeHabitFrequency(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, previousValue) {
      return AlertDialog(
        title: const Center(child: Text('Change frequency')),
        content: ButtonsRow(habit),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              habit.localFrequency = habit.frequency;
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              habit.frequency = habit.localFrequency;
              habitList.saveData();
              Navigator.pop(context, 'OK');
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}

class ButtonsRow extends StatefulWidget {
  final Habit habit;
  const ButtonsRow(this.habit, {super.key});

  @override
  State<ButtonsRow> createState() => _ButtonsRowState();
}

class _ButtonsRowState extends State<ButtonsRow> {
  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 45,
          width: 45,
          decoration: boxDecoration,
          margin: const EdgeInsets.only(right: 15),
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.habit.localFrequency > 1
                      ? widget.habit.localFrequency -= 1
                      : widget.habit.localFrequency;
                });
              },
              icon: const Icon(Icons.remove)),
        ),
        Text(widget.habit.localFrequency.toString(),
            style: Theme.of(context).textTheme.titleMedium),
        Container(
          width: 45,
          height: 45,
          decoration: boxDecoration,
          margin: const EdgeInsets.only(left: 15),
          child: IconButton(
              onPressed: () {
                setState(() {
                  widget.habit.localFrequency < 7
                      ? widget.habit.localFrequency++
                      : widget.habit.localFrequency;
                });
              },
              icon: const Icon(Icons.add)),
        )
      ],
    );
  }
}
