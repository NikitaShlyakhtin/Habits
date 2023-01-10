import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/util/const.dart';

class HabitInfo extends StatelessWidget {
  final Habit habit;
  const HabitInfo({required this.habit, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          habit.name,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
    );
  }
}
