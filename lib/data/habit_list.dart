import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_conversion.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:habit_tracker/data/habit.dart';
import 'package:habit_tracker/util/notification_service.dart';

class HabitList extends ChangeNotifier {
  late int id;
  late bool isNew;
  late int _startOfCurrentWeek;
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
        time: timeToString(time),
        id: id));

    if (reminder) {
      LocalNoticeService().scheduleDailyNotification(
          id, title, reminderText, time.hour, time.minute);
    }

    id++;

    saveData();
    notifyListeners();
  }

  void remove(Habit habit) {
    _habits.remove(habit);
    saveData();
    LocalNoticeService().cancelNotification(habit.id);
    notifyListeners();
  }

  void createInitialData() {
    id = 0;
    isNew = true;
    _startOfCurrentWeek =
        DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)).day;
    _habits = [
      Habit(
          name: 'Reading',
          color: colorToString(Colors.red[400]),
          frequency: 7,
          reminder: false,
          reminderText: 'Habits!',
          time: '16:30',
          id: 0),
      Habit(
          name: 'Sport',
          color: colorToString(Colors.blue[400]),
          frequency: 3,
          reminder: false,
          reminderText: 'Habits!',
          time: '16:30',
          id: 1)
    ];
    updateWeek();
    for (var e in _habits) {
      e.updateDoneThisYear();
    }
    saveData();
  }

  void loadData() {
    List list = box.values.toList();
    id = list[0];
    isNew = false;
    _habits = list[1].cast<Habit>();
    _startOfCurrentWeek = list[2];
    updateWeek();
    for (var e in _habits) {
      e.updateDoneThisYear();
    }
  }

  void saveData() {
    box.clear();
    box.addAll([id, _habits, _startOfCurrentWeek]);
    notifyListeners();
  }

  void updateWeek() {
    DateTime d = DateTime.now();
    int weekDay = d.weekday;
    int startOfCurrentWeek = d.subtract(Duration(days: weekDay - 1)).day;
    if (_startOfCurrentWeek != startOfCurrentWeek) {
      for (var element in _habits) {
        element.doneThisWeek = [for (int i = 0; i < 7; i++) false];
        _startOfCurrentWeek = startOfCurrentWeek;
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
