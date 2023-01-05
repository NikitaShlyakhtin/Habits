import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:habit_tracker/data/habit_list.dart';

class InputHabitRow extends StatefulWidget {
  const InputHabitRow({super.key});

  @override
  State<InputHabitRow> createState() => _InputHabitRowState();
}

class _InputHabitRowState extends State<InputHabitRow> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, child) {
      habitList.controller = myController;
      return SizedBox(
        height: 45,
        child: TextField(
          controller: myController,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10.0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceVariant,
              border: const OutlineInputBorder(
                borderRadius: borderRadius,
                borderSide: BorderSide.none,
              ),
              labelText: 'Title'),
        ),
      );
    });
  }
}
