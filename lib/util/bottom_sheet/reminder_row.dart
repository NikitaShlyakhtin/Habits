import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/widgets/my_text_field.dart';
import 'package:habit_tracker/widgets/title_column.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/util/const.dart';

class ReminderRow extends StatelessWidget {
  const ReminderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [ToggleRow(), SizedBox(height: 20), TimeRow()],
    );
  }
}

class ToggleRow extends StatelessWidget {
  const ToggleRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        TitleColumn(primary: 'Reminder', secondary: 'Just notification'),
        MySwitch()
      ],
    );
  }
}

class MySwitch extends StatefulWidget {
  const MySwitch({super.key});

  @override
  State<MySwitch> createState() => _MySwitchState();
}

class _MySwitchState extends State<MySwitch> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(
        builder: (context, habitList, child) => Transform.scale(
              scale: 1.4,
              child: Switch(
                  value: habitList.reminder,
                  onChanged: (value) {
                    setState(() {
                      habitList.reminder = !habitList.reminder;
                    });
                  }),
            ));
  }
}

class TimeRow extends StatelessWidget {
  const TimeRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const TimeContainer(), ReminderTextContainer()]);
  }
}

class TimeContainer extends StatefulWidget {
  const TimeContainer({super.key});

  @override
  State<TimeContainer> createState() => _TimeContainerState();
}

class _TimeContainerState extends State<TimeContainer> {
  TimeOfDay time = const TimeOfDay(hour: 16, minute: 30);

  @override
  Widget build(BuildContext context) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    var boxDecoration = BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: borderRadius);
    return Consumer<HabitList>(builder: (context, habitList, child) {
      return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: boxDecoration,
        child: TextButton(
          onPressed: habitList.reminder
              ? () async {
                  TimeOfDay? newTime =
                      await showTimePicker(context: context, initialTime: time);

                  if (newTime == null) return;
                  setState(() {
                    time = newTime;
                    habitList.time = time;
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
                    size: 20,
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
    });
  }
}

class ReminderTextContainer extends StatelessWidget {
  ReminderTextContainer({super.key});
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, child) {
      habitList.reminderController = myController;
      return SizedBox(
          width: 205,
          child: MyTextField(
              myController: myController,
              placeholder: 'Reminder text',
              enabled: habitList.newHabit.reminder));
    });
  }
}
