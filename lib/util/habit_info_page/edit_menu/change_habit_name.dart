import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/data/habit_list.dart';
import 'package:habit_tracker/widgets/my_text_field.dart';
import 'package:provider/provider.dart';

class ChangeHabitName extends StatelessWidget {
  final Habit habit;
  ChangeHabitName(this.habit, {super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, previousValue) {
      return AlertDialog(
        title: const Text('Enter new name'),
        content: MyTextField(
            enabled: true,
            placeholder: 'Enter new name',
            myController: myController),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (myController.text != '') {
                habit.name = myController.text;
                habitList.updateReminder();
                habitList.saveData();
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
  }
}
