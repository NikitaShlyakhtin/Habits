import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_conversion.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';

class CustomCheckbox extends StatefulWidget {
  final Habit habit;
  final int index;
  const CustomCheckbox(this.habit, this.index, {super.key});

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  final week = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    var d = DateTime.now();
    var weekDay = d.weekday;
    var dayOfWeek = d.subtract(Duration(days: weekDay - 1)).day + widget.index;
    return Column(
      children: [
        Opacity(
            opacity: 0.5,
            child: Text(
              week[widget.index],
            )),
        SizedBox(
          width: 30,
          height: 30,
          child: Consumer<HabitList>(
              builder: (context, habits, child) => ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.habit.doneThisWeek[widget.index] =
                            !widget.habit.doneThisWeek[widget.index];
                        widget.habit.doneThisWeek[widget.index]
                            ? widget.habit.done++
                            : widget.habit.done--;
                        widget.habit.updateDoneThisYear();
                        habits.saveData();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: const CircleBorder(),
                      backgroundColor: widget.habit.doneThisWeek[widget.index]
                          ? stringToColor(widget.habit.color)
                          : Theme.of(context).backgroundColor,
                    ),
                    child: Text(dayOfWeek.toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onBackground)),
                  )),
        )
      ],
    );
  }
}
