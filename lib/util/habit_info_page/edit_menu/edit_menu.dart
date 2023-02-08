import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/change_habit_frequency.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/change_habit_name.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/change_habit_reminder.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/confirm_delete_dialog.dart';

enum EditMenuItems {
  name,
  frequency,
  reminder,
  delete;

  IconData get icon {
    switch (this) {
      case delete:
        return Icons.delete_outlined;
      case name:
        return Icons.badge_outlined;
      case frequency:
        return Icons.repeat;
      case reminder:
        return Icons.notifications_outlined;
    }
  }
}

class EditMenu extends StatefulWidget {
  final Habit habit;
  const EditMenu(this.habit, {super.key});

  @override
  State<EditMenu> createState() => _EditMenuState();
}

class _EditMenuState extends State<EditMenu> {
  EditMenuItems? selectedMenu;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<EditMenuItems>(
        icon: const Icon(Icons.edit_outlined),
        onSelected: (EditMenuItems item) {
          setState(() {
            selectedMenu = item;
            _selectedMenuItemHandler(item);
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<EditMenuItems>>[
              myPopupMenuItem(EditMenuItems.name, 'Change name'),
              myPopupMenuItem(EditMenuItems.frequency, 'Change frequency'),
              myPopupMenuItem(EditMenuItems.reminder, 'Change reminder'),
              myPopupMenuItem(EditMenuItems.delete, 'Delete habit'),
            ]);
  }

  void _selectedMenuItemHandler(EditMenuItems item) {
    switch (item) {
      case EditMenuItems.name:
        showDialog(
            context: context,
            builder: (BuildContext context) => ChangeHabitName(widget.habit));
        break;
      case EditMenuItems.frequency:
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                ChangeHabitFrequency(widget.habit));
        break;
      case EditMenuItems.reminder:
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                ChangeHabitReminder(widget.habit));
        break;
      case EditMenuItems.delete:
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                ConfirmDeleteDialog(widget.habit));
        break;
    }
  }

  PopupMenuItem<EditMenuItems> myPopupMenuItem(
      EditMenuItems value, String text) {
    return PopupMenuItem<EditMenuItems>(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      value: value,
      child: Row(
        children: [
          Icon(value.icon),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}
