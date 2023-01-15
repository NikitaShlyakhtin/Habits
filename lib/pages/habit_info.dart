import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_conversion.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/edit_menu.dart';
import 'package:habit_tracker/util/habit_info_page/frequency_and_reminder_row/frequency_and_reminder.dart';
import 'package:habit_tracker/util/habit_info_page/statistic_graph.dart';
import 'package:habit_tracker/util/habit_info_page/statistic_heatmap.dart';
import 'package:habit_tracker/util/habit_info_page/statistic_numbers_row/statistic_numbers.dart';
import 'package:habit_tracker/widgets/gap.dart';

class HabitInfo extends StatelessWidget {
  final Habit habit;
  const HabitInfo({required this.habit, super.key});

  @override
  Widget build(BuildContext context) {
    double circle = habit.total / 100;
    int times = habit.times;
    int missed = habit.missed;
    int month = habit.month;
    int total = habit.total;
    List dataForHeatmap = convertForHeatmap(habit.doneThisYear);
    List<double> dataForGraph = convertForGraph(habit);

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
          actions: [EditMenu(habit)],
        ),
        body: Container(
          margin: blockMargin,
          width: double.infinity,
          child: ListView(
            children: [
              FrequencyAndReminder(
                  frequency: habit.frequency, reminder: habit.reminder),
              const Gap(),
              StatisticNumbers(circle, times, missed, month, total,
                  stringToColor(habit.color)),
              const Gap(),
              StatisticGraph(dataForGraph, stringToColor(habit.color)),
              const Gap(),
              StatisticHeatmap(dataForHeatmap, stringToColor(habit.color))
            ],
          ),
        ));
  }
}
