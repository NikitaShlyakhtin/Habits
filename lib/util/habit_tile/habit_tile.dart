import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/pages/habit_info.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:habit_tracker/util/habit_tile/checkbox.dart';

class HabitTile extends StatelessWidget {
  final Habit habit;
  const HabitTile(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HabitInfo(habit: habit),
          ),
        );
      },
      child: Container(
        height: 110,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: borderRadius),
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            HabitTileText(habit.name, habit.frequency),
            const SizedBox(height: 10),
            HabitTileWeek(habit)
          ],
        ),
      ),
    );
  }
}

class HabitTileText extends StatelessWidget {
  final String name;
  final int frequency;
  const HabitTileText(this.name, this.frequency, {super.key});

  String frequencyToString(int n) {
    return n == 7 ? 'Everyday' : '$n times a week';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name),
        Opacity(
            opacity: 0.5,
            child: Text(
              frequencyToString(frequency),
            ))
      ],
    );
  }
}

class HabitTileWeek extends StatelessWidget {
  final Habit habit;
  const HabitTileWeek(this.habit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      for (int index = 0; index < 7; index++) CustomCheckbox(habit, index)
    ]);
  }
}
