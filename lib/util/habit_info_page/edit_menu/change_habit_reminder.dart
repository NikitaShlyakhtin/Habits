import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/widgets/gap.dart';
import 'package:habit_tracker/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class ChangeHabitReminder extends StatefulWidget {
  final Habit habit;
  ChangeHabitReminder(this.habit, {super.key});

  @override
  State<ChangeHabitReminder> createState() => _ChangeHabitReminderState();
}

class _ChangeHabitReminderState extends State<ChangeHabitReminder> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, previousValue) {
      return AlertDialog(
        content: SizedBox(
          height: 100,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Reminder:',
                      style: Theme.of(context).textTheme.titleLarge),
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
              Expanded(
                child: MyTextField(
                    enabled: widget.habit.localReminder,
                    placeholder: widget.habit.reminderText,
                    myController: myController),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              widget.habit.localReminder = widget.habit.reminder;
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              widget.habit.reminder = widget.habit.localReminder;
              if (myController.text != '') {
                widget.habit.reminderText = myController.text;
              }
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
