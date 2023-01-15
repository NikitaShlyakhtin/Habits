import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/util/habit_info_page/edit_menu/confirm_delete_dialog.dart';

enum EditMenuItems { delete }

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
            showDialog(
                context: context,
                builder: (BuildContext context) =>
                    ConfirmDeleteDialog(widget.habit));
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<EditMenuItems>>[
              PopupMenuItem<EditMenuItems>(
                value: EditMenuItems.delete,
                child: Row(
                  children: const [
                    Icon(Icons.delete_outlined),
                    SizedBox(width: 5),
                    Text(
                      'Delete',
                    ),
                  ],
                ),
              ),
            ]);
  }
}
