import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/my_text_field.dart';
import 'package:provider/provider.dart';
import 'package:habit_tracker/data/habit_list.dart';

class InputHabitRow extends StatelessWidget {
  InputHabitRow({super.key});

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<HabitList>(builder: (context, habitList, child) {
      habitList.controller = myController;
      return MyTextField(
        myController: myController,
        placeholder: 'Title',
        enabled: true,
      );
    });
  }
}
