import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/data/habit.dart';

class HabitList extends ChangeNotifier {
  final NewHabit newHabit = NewHabit();
  final box = Hive.box('box');

  List<Habit> _habits = [];

  HabitList() {
    if (box.values.toList().isEmpty) {
      createInitialData();
    } else {
      loadData();
    }
  }

  List<Habit> get getHabits => (_habits);

  set controller(controller) => (newHabit.controller = controller);

  set reminderController(controller) =>
      (newHabit.reminderController = controller);

  set color(color) {
    newHabit.color = color;
  }

  int get frequency => (newHabit.frequency);

  set frequency(int n) {
    newHabit.frequency = n;
    notifyListeners();
  }

  bool get reminder => (newHabit.reminder);

  set reminder(bool value) {
    newHabit.reminder = value;
    notifyListeners();
  }

  set time(TimeOfDay time) {
    newHabit.time = time;
    notifyListeners();
  }

  void closeBottomSheet(context) {
    newHabit.controller?.text = '';
    newHabit.frequency = 3;
    newHabit.reminder = false;
    newHabit.reminderController?.text = '';
    Navigator.of(context).pop();
  }

  void add() {
    String title = newHabit.controller?.text ?? '';
    String reminderText = newHabit.reminderController?.text ?? '';
    int frequency = newHabit.frequency;
    Color? color = newHabit.color;
    TimeOfDay time = newHabit.time;
    _habits.add(Habit(
        name: title,
        frequency: frequency,
        color: colorToString(color),
        reminder: reminder,
        reminderText: reminderText,
        time: timeToString(time)));
    saveData();
    notifyListeners();
  }

  void createInitialData() {
    _habits = [
      Habit(
          name: 'Reading',
          color: colorToString(Colors.red[400]),
          frequency: 7,
          reminder: false,
          reminderText: 'Habits!',
          time: '16:30'),
      Habit(
          name: 'Sport',
          color: colorToString(Colors.blue[400]),
          frequency: 3,
          reminder: false,
          reminderText: 'Habits!',
          time: '16:30')
    ];
  }

  void loadData() {
    _habits = box.values.toList().cast<Habit>();
    updateWeek();
  }

  void saveData() {
    box.clear();
    box.addAll(_habits);
  }

  void updateWeek() {
    DateTime d = DateTime.now();
    int weekDay = d.weekday;
    int startOfCurrentWeek = d.subtract(Duration(days: weekDay - 1)).day;
    if (_habits[0].startOfCurrentWeek != startOfCurrentWeek) {
      for (var element in _habits) {
        element.doneThisWeek = [for (int i = 0; i < 7; i++) false];
        element.startOfCurrentWeek = startOfCurrentWeek;
      }
    }
    saveData();
  }
}

class NewHabit {
  TextEditingController? controller;
  TextEditingController? reminderController;
  int frequency = 3;
  bool reminder = false;
  TimeOfDay time = const TimeOfDay(hour: 16, minute: 30);
  Color? color = Colors.red[400];
}

Color stringToColor(String s) {
  return Color(int.parse(s, radix: 16));
}

String colorToString(Color? c) {
  return c.toString().split('(0x')[1].split(')')[0];
}

String timeToString(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

TimeOfDay stringToTime(String time) {
  var s = time.split(":");
  final hours = int.parse(s[0]);
  final minutes = int.parse(s[1]);
  return TimeOfDay(hour: hours, minute: minutes);
}
