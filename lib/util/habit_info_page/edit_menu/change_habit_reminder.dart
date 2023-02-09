import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_conversion.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/util/const.dart';
import 'package:habit_tracker/widgets/gap.dart';
import 'package:habit_tracker/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class ChangeHabitReminder extends StatefulWidget {
  final Habit habit;
  const ChangeHabitReminder(this.habit, {super.key});

  @override
  State<ChangeHabitReminder> createState() => _ChangeHabitReminderState();
}

class _ChangeHabitReminderState extends State<ChangeHabitReminder> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, previousValue) {
      return AlertDialog(
        title: const Center(child: Text('Reminder')),
        content: SizedBox(
          height: 105,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TimeContainer(widget.habit),
                  Switch(
                      value: widget.habit.localReminder,
                      onChanged: (value) {
                        setState(() {
                          widget.habit.localReminder =
                              !widget.habit.localReminder;
                        });
                      })
                ],
              ),
              const Gap(),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        enabled: widget.habit.localReminder,
                        placeholder: widget.habit.reminderText == ''
                            ? 'Reminder text'
                            : widget.habit.reminderText,
                        myController: myController),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.habit.localReminder = widget.habit.reminder;
              widget.habit.localTime = widget.habit.time;
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.habit.reminder = widget.habit.localReminder;
              widget.habit.time = widget.habit.localTime;
              if (myController.text != '') {
                widget.habit.reminderText = myController.text;
              }
              habitList.updateReminder();
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

class TimeContainer extends StatefulWidget {
  final Habit habit;
  const TimeContainer(this.habit, {super.key});

  @override
  State<TimeContainer> createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  late TimeOfDay time;

  @override
  Widget build(BuildContext context) {
    time = stringToTime(widget.habit.localTime);
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: boxDecoration,
      child: TextButton(
        onPressed: widget.habit.localReminder
            ? () async {
                TimeOfDay? newTime =
                    await showTimePicker(context: context, initialTime: time);

                if (newTime == null) {
                  widget.habit.localTime = widget.habit.time;
                  return;
                }
                setState(() {
                  time = newTime;
                  widget.habit.localTime = timeToString(time);
                });
              }
            : null,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Opacity(
                opacity: 0.5,
                child: Icon(
                  Icons.schedule,
                  size: 24,
                  color: Colors.white,
                )),
            const SizedBox(width: 5),
            Opacity(
                opacity: 0.9,
                child: Text('$hours:$minutes',
                    style: Theme.of(context).textTheme.bodyLarge))
          ],
        ),
      ),
    );
  }
}
